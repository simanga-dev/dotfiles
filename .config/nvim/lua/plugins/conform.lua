return {
  'stevearc/conform.nvim',
  config = function()
    local sqlfluff_config = vim.fn.stdpath 'config' .. '/.sqlfluff'

    require('conform').setup {
      notify_on_error = true,
      format_on_save = {
        timeout_ms = 10000,
        lsp_fallback = true,
      },
      formatters_by_ft = {
        lua = { 'stylua' },
        python = { 'black', 'isort' },
        sql = { 'sleek' },
        html = { 'prettierd', 'prettier' },
        json = { 'prettierd', 'prettier', stop_after_first = true },
        -- javascript = { 'prettierd', 'prettier', stop_after_first = true, lsp_format = 'fallback' },
        typescript = { 'prettierd', 'prettier', lsp_format = 'fallback' },
        typescriptreact = { 'prettierd', 'prettier', lsp_format = 'fallback' },
        -- cs = { 'csharpier_ramboe' },
        -- csproj = { 'csharpier_ramboe' },
      },
      formatters = {
        sqlfluff_one = {
          command = 'sqlfluff',
          args = { 'format', '--config', sqlfluff_config, '--dialect', 'tsql', '-' },
          -- timeout_ms = 30000,
        },
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
