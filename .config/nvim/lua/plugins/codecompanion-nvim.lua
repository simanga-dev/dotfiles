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
        adapter = 'openai',
      },
      inline = {
        adapter = 'openai',
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
      ':CodeCompanionChat Toggle <CR>',
      desc = '[GPT] Launch ChatGPT Chat',
      mode = { 'n' },
    },
    {
      '<leader>cc',
      ':CodeCompanionActions <CR>',
      desc = '[GPT] Launch ChatGPT Chat',
      mode = { 'v', 'x' },
    },
  },
  config = true,
}
