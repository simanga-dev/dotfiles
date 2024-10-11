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
      '<leader>cc',
      function()
        vim.cmd [[ ChatGPTEditWithInstruction ]]
      end,
      desc = '[GPT] Edit with instruction',
      mode = { 'v' },
    },
    {
      '<leader>g',
      function()
        vim.cmd [[ ChatGPTRun grammar_correction ]]
      end,
      desc = '[GPT] Fix Grammar',
      mode = { 'v' },
    },
    {
      '<leader>cc',
      function()
        vim.cmd [[ ChatGPT ]]
      end,
      desc = '[GPT] Launch ChatGPT Chat',
    },
    {
      '<leader>C',
      function()
        vim.cmd [[ ChatGPTActAs ]]
      end,
      desc = '[GPT] ChatGPT act AS',
    },
  },
}
