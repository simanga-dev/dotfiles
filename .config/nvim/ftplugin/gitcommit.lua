vim.keymap.set('n', '<leader>rr', function()
  local row = vim.api.nvim_win_get_cursor(0)[1] - 1
  local output = {}
  local frames = { '⠋', '⠙', '⠹', '⠸', '⠼', '⠴', '⠦', '⠧', '⠇', '⠏' }
  local i = 0
  local timer = vim.uv.new_timer()

  timer:start(
    0,
    100,
    vim.schedule_wrap(function()
      i = i % #frames + 1
      vim.api.nvim_echo({ { frames[i] .. ' lumen drafting...', 'Comment' } }, false, {})
    end)
  )

  vim.fn.jobstart({ 'lumen', 'draft' }, {
    stdout_buffered = true,
    on_stdout = function(_, data)
      for _, line in ipairs(data) do
        if line ~= '' then
          table.insert(output, line)
        end
      end
    end,
    on_exit = function()
      vim.schedule(function()
        timer:stop()
        timer:close()
        vim.api.nvim_buf_set_lines(0, row, row, false, output)
        vim.api.nvim_echo({ { '' } }, false, {})
        vim.notify('lumen draft inserted', vim.log.levels.INFO)
      end)
    end,
  })
end, { buffer = true, desc = 'Insert lumen draft at cursor' })
