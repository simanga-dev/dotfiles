return {
  'olimorris/codecompanion.nvim',
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
      mistral = function()
        return require('codecompanion.adapters').extend('ollama', {
          name = 'mistral', -- Give this adapter a different name to differentiate it from the default ollama adapter
          schema = {
            model = {
              default = 'mistral',
            },
            num_ctx = {
              default = 16384,
            },
            num_predict = {
              default = -1,
            },
          },
        })
      end,
      openai = function()
        return require('codecompanion.adapters').extend('openai', {
          env = {
            api_key = 'cmd:echo $OPENAI_API_KEY',
          },
        })
      end,
    },
  },
  -- config = true,
  keys = {
    {
      '<leader>cc',
      function()
        vim.cmd [[ CodeCompanionChat Toggle ]]
      end,
      desc = '[GPT] Edit with instruction',
      mode = { 'v', 'n' },
    },
    {
      '<leader>cc',
      function()
        vim.cmd [[CodeCompanionActions]]
      end,
      desc = '[GPT] Edit with instruction',
      mode = { 'v' },
    },
  },
}
