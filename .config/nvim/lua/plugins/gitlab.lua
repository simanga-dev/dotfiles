return {
  'harrisoncramer/gitlab.nvim',
  dependencies = {
    'MunifTanjim/nui.nvim',
    'nvim-lua/plenary.nvim',
    'sindrets/diffview.nvim',
    'stevearc/dressing.nvim', -- Recommended but not required. Better UI for pickers.
    'nvim-tree/nvim-web-devicons', -- Recommended but not required. Icons in discussion tree.
  },
  opts = {},
  keys = {
    {
      '<leader>glmc',
      function()
        require('gitlab').create_mr()
      end,
      desc = '[GL] Gitlab merge Create',
    },
    {
      '<leader>glaa',
      function()
        require('gitlab').add_assignee()
      end,
      desc = '[GL] Gitlab add assigneer for review ',
    },
    {
      '<leader>glrc',
      function()
        require('gitlab').create_comment()
      end,
      desc = '[GL] Gitlab review comment',
    },
    {
      '<leader>glrC',
      function()
        require('gitlab').create_multiline_comment()
      end,
      desc = '[GL] Gitlab review comment',
      mode = { 'v' },
    },
    {
      '<leader>glro',
      function()
        require('gitlab').open_in_browser()
      end,
      desc = '[GL] Gitlab review Open in the browser',
    },
    {
      '<leader>glmr',
      function()
        require('gitlab').review()
      end,
      desc = 'Open review on the browser',
    },
  },
  enabled = true,
  build = function()
    require('gitlab.server').build(true)
  end, -- Builds the Go binary
}
-- config = function()
--   require('gitlab').setup()
--   local gitlab = require 'gitlab'
--   local gitlab_server = require 'gitlab.server'
--   vim.keymap.set('n', '<leader>glr', gitlab.review)
--   -- thes key mapping does not  make sense, this plugin nje it have issue
--   -- vim.keymap.set('n', '<leader>gls', gitlab.summary)
--   -- vim.keymap.set('n', '<leader>glA', gitlab.approve)
--   -- vim.keymap.set('n', '<leader>glR', gitlab.revoke)
--   -- vim.keymap.set('n', '<leader>glc', gitlab.create_comment)
--   -- vim.keymap.set('v', '<leader>glc', gitlab.create_multiline_comment)
--   -- vim.keymap.set('v', '<leader>glC', gitlab.create_comment_suggestion)
--   -- vim.keymap.set('n', '<leader>glO', gitlab.create_mr)
--   -- vim.keymap.set('n', '<leader>glm', gitlab.move_to_discussion_tree_from_diagnostic)
--   -- vim.keymap.set('n', '<leader>gln', gitlab.create_note)
--   -- vim.keymap.set('n', '<leader>gld', gitlab.toggle_discussions)
--   -- vim.keymap.set('n', '<leader>glaa', gitlab.add_assignee)
--   -- vim.keymap.set('n', '<leader>glad', gitlab.delete_assignee)
--   -- vim.keymap.set('n', '<leader>glla', gitlab.add_label)
--   -- vim.keymap.set('n', '<leader>glld', gitlab.delete_label)
--   -- vim.keymap.set('n', '<leader>glra', gitlab.add_reviewer)
--   -- vim.keymap.set('n', '<leader>glrd', gitlab.delete_reviewer)
--   -- vim.keymap.set('n', '<leader>glp', gitlab.pipeline)
--   -- vim.keymap.set('n', '<leader>glo', gitlab.open_in_browser)
--   -- vim.keymap.set('n', '<leader>glM', gitlab.merge)
-- end,
