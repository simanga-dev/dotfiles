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
    },
  },
  keys = {
    -- {
    --   '<leader>cc',
    --   function()
    --     vim.cmd [[  CodeCompanionActions ]]
    --   end,
    --   desc = '[GPT] Edit with instruction',
    --   mode = { 'v' },
    -- },
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
