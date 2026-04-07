return {
  'rest-nvim/rest.nvim',
  build = false, -- skip upstream luarocks build that expects system lua5.1
  ft = { 'http' }, -- Only load for .http files
  dependencies = { 'vhyrro/luarocks.nvim' },
  config = function()
    -- Make sure local luarocks tree is on the search path (xml2lua, mimetypes)
    local home = vim.env.HOME
    package.path = table.concat({
      package.path,
      home .. '/.luarocks/share/lua/5.1/?.lua',
      home .. '/.luarocks/share/lua/5.1/?/init.lua',
    }, ';')
    package.cpath = table.concat({
      package.cpath,
      home .. '/.luarocks/lib/lua/5.1/?.so',
      home .. '/.luarocks/lib/lua/5.1/?/init.so',
    }, ';')

    require('rest-nvim').setup {
      -- Add a keybinding to the result buffer to jump to the request line
      result_split_horizontal = false,
      -- Keep the http file buffer above|left when split horizontal|vertical
      result_split_in_place = false,
      -- Skip SSL verification, useful for unknown certificates
      skip_ssl_verification = false,
      -- Encode URL before making request
      encode_url = true,
      -- Highlight request on run
      highlight = {
        enabled = true,
        timeout = 150,
      },
      -- Add a keybinding to the result buffer to jump to the request line
      result = {
        show_url = true,
        show_http_info = true,
        show_headers = true,
        -- table of curl `--write-out` variables or false if disabled
        -- for more granular control see Statistics Spec
        show_statistics = false,
        -- executables or functions for formatting response body [optional]
        -- set them to false if you want to disable them
        formatters = {
          json = 'jq',
          html = function(body)
            return vim.fn.system({ 'tidy', '-i', '-q', '-' }, body)
          end,
        },
      },
      -- Jump to request line on run
      jump_to_request = false,
      -- Run the request on the current cursor line
      env_file = '.env',
      -- Custom timeout for the request in milliseconds
      custom_dynamic_variables = {},
      -- Custom user agents
      user_agent = 'rest.nvim',
      -- Enable debug mode
      debug = false,
    }
  end,
  keys = {
    { '<leader>rr', '<cmd>Rest run<cr>', desc = 'Run REST request' },
    { '<leader>rl', '<cmd>Rest last<cr>', desc = 'Run last REST request' },
    { '<leader>rp', '<cmd>Rest preview<cr>', desc = 'Preview REST request' },
  },
}
