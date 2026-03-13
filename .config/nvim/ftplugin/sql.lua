vim.keymap.set('n', '<leader>rr', function()
  local start_line = vim.fn.search('^\\s*$', 'bnW')
  local end_line = vim.fn.search('^\\s*$', 'nW')
  -- If no blank line found, use buffer boundaries
  start_line = start_line == 0 and 1 or start_line + 1
  end_line = end_line == 0 and vim.fn.line '$' or end_line - 1

  vim.cmd(start_line .. ',' .. end_line .. 'DB')
end, { buffer = true, desc = 'Run current SQL paragraph with dadbod' })
