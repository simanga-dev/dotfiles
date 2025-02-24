return {
  'tpope/vim-fugitive',
  dependencies = {
    'shumphrey/fugitive-gitlab.vim',
    'tpope/vim-rhubarb',
    'j-hui/fidget.nvim',
  },
  event = 'VeryLazy',
  keys = {
    {
      '<leader>gA',
      function()
        local Job = require 'plenary.job'
        local fidget = require 'fidget'

        fidget.notify 'starting git add --update'
        Job:new({
          command = 'git',
          args = { 'add', '--all' },
          on_exit = function()
            fidget.notify 'git add --update completed'
          end,
        }):start()
      end,
      desc = '[G] Git add all files',
    },
    {
      '<leader>ga',
      function()
        local Job = require 'plenary.job'
        local fidget = require 'fidget'

        fidget.notify 'starting git add --update'
        Job:new({
          command = 'git',
          args = { 'add', '--update' },
          on_exit = function()
            fidget.notify 'git add --update completed'
          end,
        }):start()
      end,
      desc = '[G] Git add all files',
    },
    {
      '<leader>gB',
      function()
        vim.cmd [[ Git blame]]
      end,
      desc = '[G] Git blame ',
    },
    {
      '<leader>gc',
      function()
        vim.cmd [[ Git commit ]]
      end,
      desc = 'Launch ChatGPT',
    },
    {
      '<leader>gC',
      function()
        vim.cmd [[ Git commit --amend ]]
      end,
      desc = 'Launch ChatGPT',
    },
    {
      '<leader>gd',
      function()
        vim.cmd [[ Gvdiffsplit! ]]
      end,
      desc = 'Merge request difference',
    },
    {
      '<leader>gmt',
      function()
        vim.cmd [[ Git mergetool ]]
      end,
      desc = '[GM] Merge Tool, show file with conffilt',
    },
    {
      '<leader>gmc',
      function()
        vim.cmd [[ Git merge --continue ]]
      end,
      desc = 'git merge continue',
    },
    {
      '<leader>gw',
      function()
        vim.cmd [[ Gwrite! ]]
      end,
      desc = '[GM] Merge Tool, show file with conffilt',
    },
    {
      '<leader>gp',
      function()
        local Job = require 'plenary.job'
        local fidget = require 'fidget'

        fidget.notify 'preparing to pull to remote'
        Job:new({
          command = 'git',
          args = { 'branch', '--show-current' },
          on_exit = function(job)
            local branch = job:result()[1]
            Job:new({
              command = 'git',
              args = { 'pull', '--rebase', branch },
              on_exit = function()
                fidget.notify('Successfully pull to ' .. branch)
              end,
            }):start()
          end,
        }):start()
      end,

      desc = 'Git pull --all',
    },
    {
      '<leader>gP',
      function()
        local Job = require 'plenary.job'
        local fidget = require 'fidget'

        fidget.notify 'preparing to push to remote'
        Job:new({
          command = 'git',
          args = { 'branch', '--show-current' },
          on_exit = function(job)
            local branch = job:result()[1]

            Job:new({
              command = 'git',
              args = { 'push', 'origin', branch },
              on_exit = function()
                fidget.notify('Successfully pushed to ' .. branch)
              end,
            }):start()
          end,
        }):start()
      end,
      desc = 'Git push to current branch',
    },
    {
      '<leader>grc',
      function()
        vim.cmd [[ Git rebase --continue ]]
      end,
      desc = 'Git rebase --continue',
    },
    {
      '<leader>gmc',
      function()
        vim.cmd [[ Git merge --continue ]]
      end,
      desc = 'Git merge --continue',
    },
  },
}
