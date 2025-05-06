-- lazy.nvim
return {
  'folke/snacks.nvim',
  priority = 1000,
  lazy = false,
  opts = {
    -- scroll = {
    --   -- your scroll configuration comes here
    --   -- or leave it empty to use the default settings
    --   -- refer to the configuration section below
    -- },
    statuscolumn = {},
    picker = {
      -- your picker configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    },
    words = {
      -- your words configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    },
  },
  keys = {
    -- Top Pickers & Explorer
    {
      '<leader><space>',
      function()
        Snacks.picker.smart()
      end,
      desc = 'Smart Find Files',
    },
    {
      '<leader>sf',
      function()
        Snacks.picker.smart()
      end,
      desc = 'Smart Find Files',
    },
    {
      '<leader>ff',
      function()
        Snacks.picker.files()
      end,
      desc = 'Find Files',
    },
    {
      '<leader>,',
      function()
        Snacks.picker.buffers()
      end,
      desc = 'Buffers',
    },
    {
      '<leader>:',
      function()
        Snacks.picker.command_history()
      end,
      desc = 'Command History',
    },
    {
      '<leader>n',
      function()
        Snacks.picker.notifications()
      end,
      desc = 'Notification History',
    },
    {
      '<leader>/',
      function()
        Snacks.picker.grep()
      end,
      desc = 'Grep',
    },
    -- Grep
    {
      '<leader>sb',
      function()
        Snacks.picker.lines()
      end,
      desc = 'Buffer Lines',
    },
    {
      '<leader>sB',
      function()
        Snacks.picker.grep_buffers()
      end,
      desc = 'Grep Open Buffers',
    },
    {
      '<leader>sg',
      function()
        Snacks.picker.grep()
      end,
      desc = 'Grep',
    },
    {
      '<leader>sw',
      function()
        Snacks.picker.grep_word()
      end,
      desc = 'Visual selection or word',
      mode = { 'n', 'x' },
    },

    {
      '<leader>gb',
      function()
        Snacks.picker.git_branches()
      end,
      desc = 'Git Branches',
    },
    -- {
    --   '<leader>gl',
    --   function()
    --     Snacks.picker.git_log()
    --   end,
    --   desc = 'Git Log',
    -- },
    {
      '<leader>gL',
      function()
        Snacks.picker.git_log_line()
      end,
      desc = 'Git Log Line',
    },
    {
      '<leader>gs',
      function()
        Snacks.picker.git_status()
      end,
      desc = 'Git Status',
    },
    {
      '<leader>gS',
      function()
        Snacks.picker.git_stash()
      end,
      desc = 'Git Stash',
    },
    {
      '<leader>gd',
      function()
        Snacks.picker.git_diff()
      end,
      desc = 'Git Diff (Hunks)',
    },
    {
      '<leader>gf',
      function()
        Snacks.picker.git_log_file()
      end,
      desc = 'Git Log File',
    },
    {
      '<leader>gm',
      function()
        Snacks.picker.git_branches {
          all = true,
          layout = 'select',
          title = 'Merge Branch',
          confirm = function(picker, item)
            picker:close()
            return picker:norm(function()
              local line = item.text
              local branch = line:match '^%*?%s*([%w%-%._/]+)'
              if not branch then
                vim.notify('Could not parse branch name from: ' .. line, vim.log.levels.ERROR)
                return
              end
              vim.cmd('Git merge --no-ff ' .. branch)
            end)
          end,
        }
      end,
      desc = 'Git merge',
    },
  },
}
