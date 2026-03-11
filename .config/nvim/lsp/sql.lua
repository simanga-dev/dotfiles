return {
  cmd = {
    '/home/simanga/.local/share/nvim/mason/bin/sqls',
    '-config',
    '/home/simanga/Workspace/my-notes/db_ui/.sqls.yml',
  },
  on_attach = function(client, bufnr)
    -- require('sqls').on_attach(client, bufnr)
    --
    vim.lsp.config('sqls', {})
    vim.keymap.set('n', '<leader>dB', ':SqlsSwitchDatabase<CR>')
  end,
}
