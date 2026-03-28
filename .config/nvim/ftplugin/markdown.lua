local output_marker_start = '<!-- output-start -->'
local output_marker_end = '<!-- output-end -->'

vim.keymap.set('n', '<leader>rr', function()
  -- Only run if cursor is inside a ```bash or ```sh fenced block
  local cursor_line = vim.fn.line '.'
  local buf_lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
  local fence_start, fence_end, lang
  for i, line in ipairs(buf_lines) do
    local l = line:match '^```(%w+)'
    if l then
      fence_start = i
      lang = l
    elseif line:match '^```%s*$' and fence_start then
      fence_end = i
      if cursor_line >= fence_start and cursor_line <= fence_end then
        break
      end
      fence_start = nil
      fence_end = nil
      lang = nil
    end
  end

  if not fence_start or not fence_end then
    vim.notify('Cursor is not inside a fenced code block', vim.log.levels.WARN)
    return
  end
  if lang ~= 'bash' and lang ~= 'sh' and lang ~= 'zsh' then
    vim.notify('Only ```bash, ```sh, or ```zsh blocks can be executed', vim.log.levels.WARN)
    return
  end

  -- Extract code lines (excluding fences)
  local code_lines = vim.api.nvim_buf_get_lines(0, fence_start, fence_end - 1, false)
  local code = table.concat(code_lines, '\n')

  local bufnr = vim.api.nvim_get_current_buf()
  local result = {}

  -- Determine shell
  local shell_cmd = lang == 'zsh' and 'zsh' or 'bash'

  -- Find an existing ```output block after the code fence's closing ```
  -- Returns (start, end) as 1-indexed line numbers including the blank separator,
  -- or nil if none found.
  local function find_output_block()
    local cur_lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
    local check = fence_end -- 1-indexed, line after closing ```
    if check >= #cur_lines then
      return nil, nil
    end
    local blank_line = nil
    if cur_lines[check + 1] == '' then
      blank_line = check + 1
      check = check + 1
    end
    if cur_lines[check + 1] ~= output_marker_start then
      return nil, nil
    end
    local os = check + 1
    for i = os + 1, #cur_lines do
      if cur_lines[i] == output_marker_end then
        return blank_line or os, i
      end
    end
    return nil, nil
  end

  local function write_output(exit_code)
    vim.schedule(function()
      if not vim.api.nvim_buf_is_valid(bufnr) then
        return
      end

      local output_block = { output_marker_start }
      vim.list_extend(output_block, result)
      if exit_code ~= 0 then
        table.insert(output_block, '[exit code: ' .. exit_code .. ']')
      end
      table.insert(output_block, output_marker_end)

      local existing_start, existing_end = find_output_block()
      -- Insert blank line at start
      table.insert(output_block, 1, '')
      if existing_start and existing_end then
        vim.api.nvim_buf_set_lines(bufnr, existing_start - 1, existing_end, false, output_block)
      else
        local insert_at = fence_end
        vim.api.nvim_buf_set_lines(bufnr, insert_at, insert_at, false, output_block)
      end
    end)
  end

  -- Remove any existing output block before inserting the running indicator
  local old_start, old_end = find_output_block()
  if old_start and old_end then
    vim.api.nvim_buf_set_lines(bufnr, old_start - 1, old_end, false, {})
  end

  -- Place a running indicator immediately
  vim.api.nvim_buf_set_lines(bufnr, fence_end, fence_end, false, { '', output_marker_start, '⏳ running...', output_marker_end })

  vim.fn.jobstart({ shell_cmd, '-c', code }, {
    stdout_buffered = true,
    stderr_buffered = true,
    on_stdout = function(_, data)
      if data then
        vim.list_extend(
          result,
          vim.tbl_filter(function(l)
            return l ~= '' or #data > 1
          end, data)
        )
      end
    end,
    on_stderr = function(_, data)
      if data then
        vim.list_extend(
          result,
          vim.tbl_filter(function(l)
            return l ~= '' or #data > 1
          end, data)
        )
      end
    end,
    on_exit = function(_, exit_code)
      -- Remove trailing empty string from jobstart
      if #result > 0 and result[#result] == '' then
        table.remove(result)
      end
      write_output(exit_code)
    end,
  })
end, { buffer = true, desc = 'Run fenced bash block and show output' })
