local M = {}

local state = {
  plugins = {},
  ordered = {},
  verylazy_registered = false,
}

local plugin_fields = {
  branch = true,
  build = true,
  cmd = true,
  config = true,
  dependencies = true,
  enabled = true,
  event = true,
  ft = true,
  init = true,
  keys = true,
  lazy = true,
  main = true,
  name = true,
  opts = true,
  opts_extend = true,
  priority = true,
  requires = true,
  run = true,
  src = true,
  version = true,
}

local augroup = vim.api.nvim_create_augroup('vim-pack-loader', { clear = true })

local function notify(msg, level)
  vim.schedule(function()
    vim.notify(msg, level or vim.log.levels.INFO)
  end)
end

local function is_list(value)
  return type(value) == 'table' and vim.islist(value)
end

local function to_list(value)
  if value == nil then
    return {}
  end
  if type(value) == 'table' and vim.islist(value) then
    return value
  end
  return { value }
end

local function list_contains(list, value)
  for _, item in ipairs(list) do
    if item == value then
      return true
    end
  end
  return false
end

local function dedupe_list(list)
  local seen = {}
  local result = {}
  for _, item in ipairs(list) do
    if not seen[item] then
      seen[item] = true
      table.insert(result, item)
    end
  end
  return result
end

local function count_numeric_keys(tbl)
  local count = 0
  for key in pairs(tbl) do
    if type(key) == 'number' then
      count = count + 1
    end
  end
  return count
end

local function has_named_keys(tbl)
  for key in pairs(tbl) do
    if type(key) ~= 'number' then
      return true
    end
  end
  return false
end

local function normalize_module_specs(value)
  if type(value) == 'string' then
    return { { value } }
  end

  if type(value) ~= 'table' then
    return {}
  end

  local numeric_count = count_numeric_keys(value)
  if numeric_count == 0 then
    return { value }
  end

  if numeric_count == 1 and has_named_keys(value) then
    return { value }
  end

  local specs = {}
  for _, item in ipairs(value) do
    table.insert(specs, item)
  end
  return specs
end

local function normalize_source(source)
  if source:match('^https?://') or source:match('^git@') or source:match('^%w+://') then
    return source
  end
  if source:match('^[%w_.-]+/[%w_.-]+$') then
    return 'https://github.com/' .. source
  end
  return source
end

local function default_name(source)
  local name = source:gsub('%.git$', '')
  name = name:match('([^/]+)$') or name
  return name
end

local function default_main(plugin)
  if plugin.main then
    return plugin.main
  end

  local name = plugin.name
  name = name:gsub('%.git$', '')
  name = name:gsub('%.nvim$', '')
  name = name:gsub('%.lua$', '')
  name = name:gsub('^nvim%-', '')
  name = name:gsub('^vim%-', '')
  return name
end

local function normalize_pack_version(plugin)
  local version = plugin.version or plugin.branch
  if type(version) == 'string' and version:find('%*', 1, true) then
    return vim.version.range(version)
  end
  return version
end

local function get_path(tbl, path)
  local current = tbl
  for segment in path:gmatch('[^.]+') do
    if type(current) ~= 'table' then
      return nil
    end
    current = current[segment]
    if current == nil then
      return nil
    end
  end
  return current
end

local function set_path(tbl, path, value)
  local current = tbl
  local parts = vim.split(path, '.', { plain = true })
  for i = 1, #parts - 1 do
    local segment = parts[i]
    if type(current[segment]) ~= 'table' then
      current[segment] = {}
    end
    current = current[segment]
  end
  current[parts[#parts]] = value
end

local function merge_opts(base, extra, extend_paths)
  if base == nil then
    return vim.deepcopy(extra)
  end

  local merged = vim.deepcopy(base)
  local incoming = vim.deepcopy(extra)

  for _, path in ipairs(extend_paths) do
    local current_value = get_path(merged, path)
    local incoming_value = get_path(incoming, path)
    if is_list(current_value) and is_list(incoming_value) then
      set_path(incoming, path, dedupe_list(vim.list_extend(vim.deepcopy(current_value), incoming_value)))
    end
  end

  return vim.tbl_deep_extend('force', merged, incoming)
end

local function make_proxy(plugin)
  return {
    name = plugin.name,
    main = plugin.main,
    branch = plugin.branch,
    version = plugin.version,
    lazy = plugin.lazy,
    priority = plugin.priority,
  }
end

local function extract_name(spec)
  local source = spec.src or spec[1]
  if type(source) ~= 'string' then
    return nil, nil
  end

  local name = spec.name or default_name(source)
  return name, source
end

local function new_plugin(name, source)
  return {
    name = name,
    source = source,
    src = normalize_source(source),
    main = nil,
    branch = nil,
    version = nil,
    priority = 0,
    lazy = nil,
    opts_fragments = {},
    opts_extend = {},
    config_handlers = {},
    init_handlers = {},
    build_handlers = {},
    keys = {},
    commands = {},
    filetypes = {},
    events = {},
    dependencies = {},
    loaded = false,
    configured = false,
    actual_keys_set = false,
    stub_keys_set = false,
    stub_commands_set = false,
  }
end

local register_spec

local function append_unique(target, items)
  for _, item in ipairs(items) do
    if item ~= nil and not list_contains(target, item) then
      table.insert(target, item)
    end
  end
end

local function register_dependency_specs(value)
  local names = {}
  for _, dep in ipairs(normalize_module_specs(value)) do
    if type(dep) == 'string' then
      dep = { dep }
    end
    local name = register_spec(dep)
    if name ~= nil then
      table.insert(names, name)
    end
  end
  return names
end

register_spec = function(spec)
  if type(spec) == 'string' then
    spec = { spec }
  end

  if type(spec) ~= 'table' or spec.enabled == false then
    return nil
  end

  local name, source = extract_name(spec)
  if name == nil then
    return nil
  end

  local plugin = state.plugins[name]
  if plugin == nil then
    plugin = new_plugin(name, source)
    state.plugins[name] = plugin
    table.insert(state.ordered, name)
  end

  plugin.source = source
  plugin.src = normalize_source(source)
  plugin.main = spec.main or plugin.main
  plugin.branch = spec.branch or plugin.branch
  plugin.version = spec.version or plugin.version
  plugin.priority = math.max(plugin.priority or 0, spec.priority or 0)
  if spec.lazy ~= nil then
    plugin.lazy = spec.lazy
  end

  if spec.opts ~= nil then
    table.insert(plugin.opts_fragments, spec.opts)
  end

  append_unique(plugin.opts_extend, to_list(spec.opts_extend))

  if spec.config ~= nil then
    table.insert(plugin.config_handlers, spec.config)
  end
  if spec.init ~= nil then
    table.insert(plugin.init_handlers, spec.init)
  end

  local build = spec.build ~= nil and spec.build or spec.run
  if build ~= nil and build ~= false then
    table.insert(plugin.build_handlers, build)
  end

  append_unique(plugin.keys, to_list(spec.keys))
  append_unique(plugin.commands, to_list(spec.cmd))
  append_unique(plugin.filetypes, to_list(spec.ft))
  append_unique(plugin.events, to_list(spec.event))
  append_unique(plugin.dependencies, register_dependency_specs(spec.dependencies))
  append_unique(plugin.dependencies, register_dependency_specs(spec.requires))

  plugin.proxy = make_proxy(plugin)
  return name
end

local function resolve_opts(plugin)
  if plugin.resolved_opts ~= nil or plugin.opts_resolved then
    return plugin.resolved_opts
  end

  local opts = nil
  for _, fragment in ipairs(plugin.opts_fragments) do
    if type(fragment) == 'function' then
      local current = opts or {}
      local result = fragment(plugin.proxy, current)
      opts = result ~= nil and result or current
    else
      opts = merge_opts(opts, fragment, plugin.opts_extend)
    end
  end

  plugin.resolved_opts = opts
  plugin.opts_resolved = true
  return opts
end

local function delete_keymap(mode, lhs)
  pcall(vim.keymap.del, mode, lhs)
end

local function actual_keymap(plugin, spec)
  local lhs = spec[1]
  local rhs = spec[2]
  if lhs == nil or rhs == nil then
    return
  end

  local modes = to_list(spec.mode or 'n')
  local opts = {}
  for key, value in pairs(spec) do
    if type(key) ~= 'number' and key ~= 'mode' then
      opts[key] = value
    end
  end

  vim.keymap.set(modes, lhs, rhs, opts)
end

local function install_actual_keys(plugin)
  if plugin.actual_keys_set then
    return
  end

  for _, spec in ipairs(plugin.keys) do
    if type(spec) == 'table' then
      local lhs = spec[1]
      local modes = to_list(spec.mode or 'n')
      for _, mode in ipairs(modes) do
        delete_keymap(mode, lhs)
      end
      actual_keymap(plugin, spec)
    end
  end

  plugin.actual_keys_set = true
end

local function run_auto_setup(plugin, opts)
  local main = default_main(plugin)
  local ok, module = pcall(require, main)
  if not ok then
    notify(string.format('vim.pack: failed to require %s for %s', main, plugin.name), vim.log.levels.ERROR)
    return
  end

  if type(module.setup) ~= 'function' then
    notify(string.format('vim.pack: %s has no setup() for %s', main, plugin.name), vim.log.levels.ERROR)
    return
  end

  module.setup(opts or {})
end

local function load_plugin(name)
  local plugin = state.plugins[name]
  if plugin == nil or plugin.loaded then
    return
  end

  for _, dependency in ipairs(plugin.dependencies) do
    load_plugin(dependency)
  end

  local ok, err = pcall(vim.cmd.packadd, plugin.name)
  if not ok then
    notify(string.format('vim.pack: failed to load %s: %s', plugin.name, err), vim.log.levels.ERROR)
    return
  end

  plugin.loaded = true

  local opts = resolve_opts(plugin)
  if not plugin.configured then
    if #plugin.config_handlers == 0 and opts ~= nil then
      run_auto_setup(plugin, opts)
    else
      for _, handler in ipairs(plugin.config_handlers) do
        if handler == true then
          run_auto_setup(plugin, opts)
        elseif type(handler) == 'function' then
          handler(plugin.proxy, opts)
        end
      end
    end
    plugin.configured = true
  end

  install_actual_keys(plugin)
end

local function set_stub_keymaps(plugin)
  if plugin.stub_keys_set then
    return
  end

  for _, spec in ipairs(plugin.keys) do
    if type(spec) == 'table' and spec[1] ~= nil then
      local lhs = spec[1]
      local modes = to_list(spec.mode or 'n')
      local opts = {}
      for key, value in pairs(spec) do
        if type(key) ~= 'number' and key ~= 'mode' then
          opts[key] = value
        end
      end

      opts.callback = nil
      vim.keymap.set(modes, lhs, function()
        load_plugin(plugin.name)
        vim.schedule(function()
          vim.api.nvim_feedkeys(vim.keycode(lhs), 'm', false)
        end)
      end, opts)
    end
  end

  plugin.stub_keys_set = true
end

local function command_stub(plugin, command_name)
  return function(ctx)
    pcall(vim.api.nvim_del_user_command, command_name)
    plugin.stub_commands_set = false
    load_plugin(plugin.name)

    local ok, err = pcall(vim.api.nvim_cmd, {
      cmd = command_name,
      args = ctx.fargs,
      bang = ctx.bang,
      mods = ctx.smods,
      range = ctx.range > 0 and { ctx.line1, ctx.line2 } or nil,
      count = ctx.count >= 0 and ctx.count or nil,
    }, {})

    if not ok then
      notify(string.format('vim.pack: failed to run %s after loading %s: %s', command_name, plugin.name, err), vim.log.levels.ERROR)
    end
  end
end

local function set_stub_commands(plugin)
  if plugin.stub_commands_set then
    return
  end

  for _, command_name in ipairs(plugin.commands) do
    vim.api.nvim_create_user_command(command_name, command_stub(plugin, command_name), {
      nargs = '*',
      bang = true,
      range = true,
      complete = 'file',
    })
  end

  plugin.stub_commands_set = true
end

local function set_filetype_autocmds(plugin)
  if #plugin.filetypes == 0 then
    return
  end

  vim.api.nvim_create_autocmd('FileType', {
    group = augroup,
    pattern = plugin.filetypes,
    once = true,
    callback = function()
      load_plugin(plugin.name)
    end,
  })
end

local function ensure_verylazy_event()
  if state.verylazy_registered then
    return
  end

  state.verylazy_registered = true
  vim.api.nvim_create_autocmd('VimEnter', {
    group = augroup,
    once = true,
    callback = function()
      vim.schedule(function()
        vim.api.nvim_exec_autocmds('User', { pattern = 'VeryLazy' })
      end)
    end,
  })
end

local function set_event_autocmds(plugin)
  for _, event in ipairs(plugin.events) do
    if event == 'VeryLazy' then
      ensure_verylazy_event()
      vim.api.nvim_create_autocmd('User', {
        group = augroup,
        pattern = 'VeryLazy',
        once = true,
        callback = function()
          load_plugin(plugin.name)
        end,
      })
    else
      vim.api.nvim_create_autocmd(event, {
        group = augroup,
        once = true,
        callback = function()
          load_plugin(plugin.name)
        end,
      })
    end
  end
end

local function should_start(plugin)
  if plugin.lazy == false then
    return true
  end

  return #plugin.events == 0 and #plugin.filetypes == 0 and #plugin.commands == 0 and #plugin.keys == 0
end

local function run_build(plugin, path)
  if #plugin.build_handlers == 0 then
    return
  end

  local loaded_before = plugin.loaded
  if not loaded_before then
    pcall(vim.cmd.packadd, plugin.name)
  end

  for _, build in ipairs(plugin.build_handlers) do
    if type(build) == 'function' then
      build(plugin.proxy)
    elseif type(build) == 'string' and build ~= '' then
      if vim.startswith(build, ':') then
        vim.cmd(build:sub(2))
      else
        local result = vim.system({ vim.o.shell, vim.o.shellcmdflag, build }, { cwd = path }):wait()
        if result.code ~= 0 then
          notify(string.format('vim.pack: build failed for %s: %s', plugin.name, result.stderr), vim.log.levels.ERROR)
        end
      end
    end
  end

  if not loaded_before then
    plugin.loaded = false
    plugin.configured = false
    plugin.actual_keys_set = false
  end
end

local function register_build_hooks()
  vim.api.nvim_create_autocmd('PackChanged', {
    group = augroup,
    callback = function(ev)
      local plugin = state.plugins[ev.data.spec.name]
      if plugin == nil then
        return
      end

      if ev.data.kind == 'install' or ev.data.kind == 'update' then
        run_build(plugin, ev.data.path)
      end
    end,
  })
end

local function collect_plugins()
  local plugins_dir = vim.fs.joinpath(vim.fn.stdpath 'config', 'lua', 'plugins')
  local entries = {}

  for name, kind in vim.fs.dir(plugins_dir) do
    if kind == 'file' and name:sub(-4) == '.lua' then
      table.insert(entries, name)
    end
  end

  table.sort(entries)

  for _, name in ipairs(entries) do
    local module_name = 'plugins.' .. name:gsub('%.lua$', '')
    local ok, specs = pcall(require, module_name)
    if not ok then
      notify(string.format('vim.pack: failed to read %s: %s', module_name, specs), vim.log.levels.ERROR)
    else
      for _, spec in ipairs(normalize_module_specs(specs)) do
        register_spec(spec)
      end
    end
  end
end

local function run_init_handlers()
  for _, name in ipairs(state.ordered) do
    local plugin = state.plugins[name]
    for _, handler in ipairs(plugin.init_handlers) do
      if type(handler) == 'function' then
        handler(plugin.proxy)
      end
    end
  end
end

local function add_all_plugins()
  local specs = {}
  for _, name in ipairs(state.ordered) do
    local plugin = state.plugins[name]
    table.insert(specs, {
      src = plugin.src,
      name = plugin.name,
      version = normalize_pack_version(plugin),
    })
  end

  vim.pack.add(specs, { load = false, confirm = false })
end

local function register_lazy_triggers()
  for _, name in ipairs(state.ordered) do
    local plugin = state.plugins[name]
    if not should_start(plugin) then
      set_stub_keymaps(plugin)
      set_stub_commands(plugin)
      set_filetype_autocmds(plugin)
      set_event_autocmds(plugin)
    end
  end
end

local function start_plugins()
  local startup = {}
  for _, name in ipairs(state.ordered) do
    local plugin = state.plugins[name]
    if should_start(plugin) then
      table.insert(startup, plugin)
    end
  end

  table.sort(startup, function(a, b)
    if a.priority == b.priority then
      return a.name < b.name
    end
    return a.priority > b.priority
  end)

  for _, plugin in ipairs(startup) do
    load_plugin(plugin.name)
  end
end

function M.setup()
  collect_plugins()
  register_build_hooks()
  run_init_handlers()
  add_all_plugins()
  register_lazy_triggers()
  start_plugins()
end

return M
