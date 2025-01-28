return {
  'huynle/ogpt.nvim',
  event = 'VeryLazy',
  opts = {
    default_provider = 'ollama',
  },
  dependencies = {
    'MunifTanjim/nui.nvim',
    'nvim-lua/plenary.nvim',
    'nvim-telescope/telescope.nvim',
  },
}
