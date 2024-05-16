return {
  'stevearc/conform.nvim',
  opts = {
    notify_on_error = true,
    fomat_on_save = {
      timeout_ms = 500,
      lsp_fallback = true,
    },
    formatters_by_ft = {
      lua = { 'stylua' },
      python = { 'black', 'isort' },
      javascript = { { 'prettierd', 'prettier' } },
      html = { { 'prettierd', 'prettier' } },
    },
  },
  config = function()
    require('conform').setup {
      format_on_save = {
        timeout_ms = 500,
        lsp_fallback = true,
      },
      formatters_by_ft = {
        lua = { 'stylua' },
        python = { 'black', 'isort' },
        javascript = { 'prettierd', 'prettier' },
        html = { 'prettierd', 'prettier' },
        svelte = { 'prettierd', 'prettier' },
        sql = { 'sqlformat' },
      },
    }
  end,
}
