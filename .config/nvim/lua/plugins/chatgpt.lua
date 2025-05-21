return {
  'jackMort/ChatGPT.nvim',
  dependencies = {
    'MunifTanjim/nui.nvim',
    'nvim-lua/plenary.nvim',
    'folke/which-key.nvim',
    'nvim-telescope/telescope.nvim',
    'jbyuki/one-small-step-for-vimkind',
  },
  event = 'VeryLazy',
  lazy = true,
  -- commit       = "aa8a969",
  opts = {
    {
      openai_params = {
        model = 'gpt-4-1106-preview',
        frequency_penalty = 0,
        presence_penalty = 0,
        max_tokens = 4095,
        temperature = 0.2,
        top_p = 0.1,
        n = 1,
      },
    },
  },
  keys = {
    {
      '<leader>gg',
      function()
        vim.cmd [[ ChatGPT ]]
      end,
      desc = '[GPT] Edit with instruction',
      mode = { 'n' }, -- the selected code must be open on a chat buffer
    },
    {
      '<leader>gg',
      function()
        vim.cmd [[ ChatGPTRun grammar_correction ]]
      end,
      desc = '[GPT] Fix spelling and gramma',
      mode = { 'v' }, -- the selected code must be open on a chat buffer
    },
  },
}
