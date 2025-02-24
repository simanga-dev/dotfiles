require 'option'
require 'keymap'

local borders = require('icons').borders

local cmd = vim.api.nvim_command
local disable_distribution_plugins = function()
  cmd [[ let g:neo_tree_remove_legacy_commands = 1 ]]
  vim.g.loaded_gzip = 1
  vim.g.loaded_tar = 1
  vim.g.loaded_tarPlugin = 1
  vim.g.loaded_zip = 1
  vim.g.loaded_zipPlugin = 1
  vim.g.loaded_getscript = 1
  vim.g.loaded_getscriptPlugin = 1
  vim.g.loaded_vimball = 1
  vim.g.loaded_vimballPlugin = 1
  vim.g.loaded_matchit = 1
  --     vim.g.loaded_matchparen = 1
  vim.g.loaded_2html_plugin = 1
  vim.g.loaded_logiPat = 1
  vim.g.loaded_rrhelper = 1
  vim.g.loaded_netrw = 1
  vim.g.loaded_netrwPlugin = 1
  vim.g.loaded_netrwSettings = 1
  vim.g.loaded_netrwFileHandlers = 1

  vim.api.nvim_create_user_command('Browse', function(opts)
    vim.fn.system { 'xdg-open', opts.fargs[1] }
  end, { nargs = 1 })
end

disable_distribution_plugins()

local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

require('lazy').setup('plugins', {
  ui = { border = borders },
  change_detection = {
    enabled = true,
    notify = false, -- get a notification when changes are found
  },
})

cmd [[
  se stl:— fcs=stl:─,stlnc:—

  hi StatusLine gui=NONE guibg=NONE
  hi StatusLineNC gui=NONE guibg=NONE

  hi Normal guibg=NONE ctermbg=NONE
  hi NonText guibg=NONE ctermbg=NONE
  hi EndOfBuffer guibg=NONE ctermbg=NONE

  hi SignColumn guibg=NONE ctermbg=NONE
  hi NormalFloat guibg=NONE ctermbg=NONE

  hi NotificationInfo guibg=NONE
  hi NotificationWarning guibg=NONE
  hi NotificationError guibg=NONE

  set exrc
  set secure

  set termguicolors

  set guicursor=n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50
]]
