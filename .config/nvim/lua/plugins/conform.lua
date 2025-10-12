return {
  'stevearc/conform.nvim',
  config = function()
    require('conform').setup {
      notify_on_error = true,
      fomat_on_save = {
        timeout_ms = 10000,
        lsp_fallback = true,
      },
      formatters_by_ft = {
        lua = { 'stylua' },
        python = { 'black', 'isort' },
        javascript = { 'biome', 'prettierd', lsp_format = 'fallback' },
        typescript = { 'biome', 'prettierd', lsp_format = 'fallback' },
        typescriptreact = { 'prettierd', 'prettier', lsp_format = 'fallback' },
        json = { 'biome', 'jq', lsp_format = 'fallback' },

        html = { 'prettierd', 'prettier' },
        -- sql = { 'sqlfluff', lsp_format = 'fallback' }, when I have time to configure it the way I want to but for now pg_format is more than enough
        sql = { 'pg_format', lsp_format = 'fallback' },
        cs = { 'csharpier_ramboe' },
        csproj = { 'csharpier_ramboe' },
      },
      formatters = {
        csharpier_ramboe = {
          command = 'csharpier',
          args = {
            'format',
            '--write-stdout',
          },
          to_stdin = true,
        },
      },
    }

    vim.api.nvim_create_autocmd('BufWritePre', {
      pattern = '*',
      callback = function(args)
        require('conform').format { bufnr = args.buf }
      end,
    })

    vim.api.nvim_create_autocmd('FocusLost', {
      pattern = '*',
      callback = function(args)
        require('conform').format { bufnr = args.buf }
      end,
    })

    -- require('conform').formatters.sql = {
    --   prepend_args = { 'fix', '-x' },
    -- }
  end,
}
