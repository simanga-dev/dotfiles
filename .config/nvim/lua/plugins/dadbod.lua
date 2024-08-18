return {
  'kristijanhusak/vim-dadbod-ui',
  dependencies = {
    'tpope/vim-dadbod',
    { 'kristijanhusak/vim-dadbod-completion', ft = { 'sql', 'mysql', 'plsql' }, lazy = true },
  },
  cmd = {
    'DBUI',
    'DBUIToggle',
    'DBUIAddConnection',
    'DBUIFindBuffer',
  },
  keys = {
    {
      '<leader>db',
      function()
        vim.cmd [[ DBUIToggle ]]
      end,
      desc = 'Launch Dadbod UI',
    },
  },
  init = function()
    -- Your DBUI configuration
    vim.g.db_ui_use_nerd_fonts = 1
    vim.g.db_ui_default_query = 'SELECT * FROM "{table}" LIMIT 2;'
    vim.g.db_ui_use_nerd_fonts = 1
    vim.g.db_ui_save_location = '~/workspace/my-notes/db_ui'
    vim.g.db_ui_execute_on_save = 0

    require('cmp').setup.buffer { sources = { { name = 'vim-dadbod-completion' } } }

    vim.api.nvim_create_autocmd({ 'BufReadPost' }, {
      pattern = { '*.dbout' },
      callback = function()
        vim.api.nvim_exec2([[ exe ':resize 15' ]], {})
        vim.g.db_ui_use_nerd_fonts = 1
      end,
    })
  end,
}
