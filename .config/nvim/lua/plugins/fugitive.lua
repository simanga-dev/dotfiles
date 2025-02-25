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
          on_exit = function(job, code)
            if code ~= 0 then
              fidget.notify('Error retrieving branch: ' .. table.concat(job:stderr_result(), '\n'))
              return
            end
            local branch = job:result()[1]
            Job:new({
              command = 'git',
              args = { 'pull', '--rebase', 'origin', branch },
              on_exit = function(pull_job, pull_code)
                if pull_code ~= 0 then
                  local error_output = table.concat(pull_job:stderr_result(), '\n')
                  fidget.notify('Error pulling branch ' .. branch .. ':\n' .. error_output)
                else
                  local success_output = table.concat(pull_job:result(), '\n')
                  fidget.notify('Successfully pulled to ' .. branch .. '\nOutput:\n' .. success_output)
                end
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
          on_exit = function(job, code)
            if code ~= 0 then
              fidget.notify('Error retrieving branch: ' .. table.concat(job:stderr_result(), '\n'))
              return
            end
            local branch = job:result()[1]

            Job:new({
              command = 'git',
              args = { 'push', 'origin', branch },
              on_exit = function(push_job, push_code)
                if push_code ~= 0 then
                  local error_output = table.concat(push_job:stderr_result(), '\n')
                  fidget.notify('Error pushing branch ' .. branch .. ':\n' .. error_output)
                else
                  local success_output = table.concat(push_job:result(), '\n')
                  fidget.notify('Successfully pushed to ' .. branch .. '\nOutput:\n' .. success_output)
                end
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
