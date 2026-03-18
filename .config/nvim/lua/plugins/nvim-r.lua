return {
  'R-nvim/R.nvim',
  lazy = false,
  opts = {
    R_args = { '--quiet', '--no-save' },
    hook = {
      on_filetype = function()
        vim.api.nvim_buf_set_keymap(0, 'n', '<Enter>', '<Plug>RDSendLine', {})
        vim.api.nvim_buf_set_keymap(0, 'v', '<Enter>', '<Plug>RSendSelection', {})
      end,
    },
    rconsole_width = 0,
    rconsole_height = 15,
    disable_cmds = {
      'RClearConsole',
      'RCustomStart',
      'RSPlot',
      'RSaveClose',
    },
  },
}
