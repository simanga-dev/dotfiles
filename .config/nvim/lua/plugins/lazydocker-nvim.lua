-- lazydocker.nvim
return {
  'mgierada/lazydocker.nvim',
  dependencies = { 'akinsho/toggleterm.nvim' },
  config = function()
    require('lazydocker').setup {
      border = 'curved', -- valid options are "single" | "double" | "shadow" | "curved"
      window = {
        settings = {
          width = 0.8,
          height = 0.8,
          border = 'rounded',
          relative = 'editor',
        },
      },
    }
  end,
  event = 'BufRead',
  keys = {
    {
      '<leader>ld',
      function()
        require('lazydocker').open()
      end,
      desc = 'Open Lazydocker floating window',
    },
  },
}
