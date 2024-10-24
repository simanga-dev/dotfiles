return {
  'tpope/vim-fugitive',
  dependencies = {
    'shumphrey/fugitive-gitlab.vim',
    'tpope/vim-rhubarb',
  },
  event = 'VeryLazy',
  keys = {
    {
      '<leader>gA',
      function()
        vim.cmd [[ Git add . ]]
      end,
      desc = '[G] Git add all files',
    },
    {
      '<leader>ga',
      function()
        vim.cmd [[ Git add --update ]]
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
        vim.cmd [[silent! Git stash]]
        vim.cmd [[ Git pull --all --rebase ]]
      end,
      desc = 'Git pull --all',
    },
    {
      '<leader>gP',
      function()
        local branch = vim.system({ 'git', 'branch --show-current' }, { text = true }):wait()
        vim.cmd [[silent! Git stash]]
        vim.cmd [[silent! Git pull --all --rebase ]]
        local git_push = 'Git push origin ' .. branch.stdout
        vim.cmd(git_push)
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
