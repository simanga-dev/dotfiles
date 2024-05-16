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
        max_tokens = 500,
        model = 'gpt-4-0125-preview',
      },
    },
  },
  keys = {
    {
      '<leader>cx',
      function()
        vim.cmd [[ ChatGPTRun explain_code ]]
      end,
      desc = '[GPT] Explain code',
      mode = { 'n', 'v' },
    },
    {
      '<leader>ce',
      function()
        vim.cmd [[ ChatGPTEditWithInstruction ]]
      end,
      desc = '[GPT] Edit with instruction',
      mode = { 'n', 'v' },
    },
    {
      '<leader>cg',
      function()
        vim.cmd [[ ChatGPTRun grammar_correction ]]
      end,
      desc = '[GPT] Fix Grammar',
      mode = { 'n', 'v' },
    },
    {
      '<leader>cc',
      function()
        vim.cmd [[ ChatGPT ]]
      end,
      desc = '[GPT] Launch ChatGPT Chat',
    },
    {
      '<leader>cC',
      function()
        vim.cmd [[ ChatGPTActAs ]]
      end,
      desc = '[GPT] ChatGPT act AS',
    },
  },
}
