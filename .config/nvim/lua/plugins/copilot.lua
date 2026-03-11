return {
  'zbirenbaum/copilot.lua',
  cmd = 'Copilot',
  event = 'InsertEnter',
  config = function()
    require('copilot').setup {
      filetypes = {
        ['*'] = true, -- disable for all other filetypes and ignore default `filetypes`
      },
    }
  end,
}
