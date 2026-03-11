vim.keymap.set('n', '<leader>rr', function()
  vim.cmd 'normal! vip"zy'
  local lines = vim.split(vim.fn.getreg 'z', '\n', { plain = true })
  lines = vim.tbl_filter(function(line)
    return not line:match '^```'
  end, lines)
  local output = vim.fn.systemlist(table.concat(lines, '\n'))
  local pos = vim.fn.getpos '.'
  local last_line = vim.fn.line '$'
  vim.cmd 'normal! }'
  local first_blank = vim.fn.line '.'
  if first_blank == last_line then
    vim.api.nvim_buf_set_lines(0, last_line, last_line, false, { '' })
    vim.api.nvim_buf_set_lines(0, last_line + 1, last_line + 1, false, output)
  else
    vim.cmd 'normal! }'
    local second_blank = vim.fn.line '.'
    if second_blank == first_blank or first_blank + 1 > second_blank - 1 then
      vim.api.nvim_buf_set_lines(0, first_blank, first_blank, false, output)
    else
      vim.api.nvim_buf_set_lines(0, first_blank, second_blank - 1, false, output)
    end
  end
  vim.fn.setpos('.', pos)
end, { buffer = true, desc = 'Run paragraph through bash' })
