return {
  'olimorris/codecompanion.nvim',
  event = 'InsertEnter',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-treesitter/nvim-treesitter',
  },
  opts = {
    strategies = {
      chat = {
        adapter = 'gemini',
      },
      inline = {
        adapter = 'gemini',
      },
    },
    adapters = {

      openai = function()
        return require('codecompanion.adapters').extend('openai', {
          env = {
            api_key = 'cmd:echo $OPENAI_API_KEY',
          },
        })
      end,

      gemini = function()
        return require('codecompanion.adapters').extend('gemini', {
          env = {
            api_key = 'cmd:echo $GEMINI_API_KEY',
          },
        })
      end,
    },
  },
  keys = {
    {
      '<leader>cc',
      function()
        vim.cmd [[ CodeCompanionChat Toggle ]]
      end,
      desc = '[GPT] Launch ChatGPT Chat',
      mode = { 'v', 'n' },
    },
    {
      '<leader>cl',
      ':CodeCompanion',
      desc = '[GPT] Launch ChatGPT Chat',
      mode = { 'v', 'n' },
    },
  },
  config = true,
}
