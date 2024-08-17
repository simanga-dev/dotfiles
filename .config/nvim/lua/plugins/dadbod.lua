return {
  'kristijanhusak/vim-dadbod-ui',
  dependencies = {
    'tpope/vim-dadbod',
    -- { 'kristijanhusak/vim-dadbod-completion', ft = { 'sql', 'mysql', 'plsql' }, lazy = true },
    { 'kristijanhusak/vim-dadbod-completion' },
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
  config = function()
    vim.g.db_ui_use_nerd_fonts = 1
    vim.g.db_ui_default_query = 'SELECT * FROM "{table}" LIMIT 2;'

    vim.api.nvim_create_autocmd({ 'BufReadPost' }, {
      pattern = { '*.dbout' },
      callback = function()
        vim.api.nvim_exec2(
          [[
          exe ':resize 15'
          ]],
          {}
        )
      end,
    })
    vim.cmd [[
            " Source is automatically added, you just need to include it in the chain complete list
            let g:db_ui_save_location = '~/workspace/my-notes/db_ui'
            let g:completion_matching_strategy_list = ['exact', 'substring']
            let g:db_ui_execute_on_save = 0
            " g:db_ui_execute_on_save = 1
            " g:db_ui_use_nvim_notify = 1
            " g:db_ui_execute_on_save = 1
            let g:completion_chain_complete_list = {
                \   'sql': [
                \    {'complete_items': ['vim-dadbod-completion']},
                \   ],
                \ }

        ]]
  end,
}
