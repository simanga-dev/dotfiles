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

-- " se stl:— fcs=stl:─,stlnc:—
-- se fcs=stl:─,stlnc:—
cmd [[
    se stl:— fcs=stl:─,stlnc:—

    hi FoldColumn guibg=NONE

    hi SignColumn guibg=NONE ctermbg=NONE
    hi Folded guibg=NONE ctermbg=NONE
    hi NormalFloat guibg=NONE ctermbg=NONE
    hi FloatBorder guibg=NONE ctermbg=NONE

    hi WinSeparator guibg=NONE ctermbg=NONE
    hi WinBar guibg=NONE ctermbg=NONE
    hi WinBarNC guibg=NONE ctermbg=NONE

    hi Normal guibg=NONE ctermbg=NONE
    hi NormalFloat guibg=NONE ctermbg=NONE
    hi CursorLine guibg=NONE ctermbg=NONE
    hi NormalNC guibg=NONE ctermbg=NONE
    hi PMenu guibg=NONE ctermbg=NONE
    hi PMenuSBar guibg=NONE  ctermbg=NONE
    hi PMenuThumb guibg=NONE ctermbg=NONE
    hi WildMenu guibg=NONE ctermbg=NONE
    hi VertSplit ctermbg=NONE guibg=NONE

    hi StatusLine gui=NONE guifg=#565f89 guibg=NONE
    hi StatusLineNC gui=NONE guifg=#565f89 guibg=NONE
    hi VertSplit gui=NONE guifg=#565f89 guibg=NONE cterm=NONE
    hi WinSeparator gui=NONE guifg=#565f89 guibg=NONE cterm=NONE

    hi TabLineFill guifg=NONE guibg=NONE
    hi TabLine guifg=#565f89  guibg=NONE
    hi TabLineSel guifg=#565f89  guibg=NONE

    hi NotificationInfo guifg=#565f89 guibg=NONE
    hi NotificationWarning guifg=#565f89 guibg=NONE
    hi NotificationError guifg=#565f89 guibg=NONE
    set exrc
    set secure

    set guicursor=n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50


"  _   _                 _            
" | \ | | ___  _____   _(_)_ __ ___   
" |  \| |/ _ \/ _ \ \ / / | '_ ` _ \  
" | |\  |  __/ (_) \ V /| | | | | | | 
" |_| \_|\___|\___/ \_/ |_|_| |_| |_| 
"                                     
" by Stephan Raabe (2023) 
" ----------------------------------------------------- 

set nocompatible            " disable compatibility to old-time vi
set showmatch               " show matching 
set ignorecase              " case insensitive 
set mouse=v                 " middle-click paste with 
set hlsearch                " highlight search 
set incsearch               " incremental search
set tabstop=4               " number of columns occupied by a tab 
set softtabstop=4           " see multiple spaces as tabstops so <BS> does the right thing
set expandtab               " converts tabs to white space
set shiftwidth=4            " width for autoindents
set autoindent              " indent a new line the same amount as the line just typed
set number                  " add line numbers
set wildmode=longest,list   " get bash-like tab completions
" set cc=80                   " set an 80 column border for good coding style
filetype plugin indent on   "allow auto-indenting depending on file type
syntax on                   " syntax highlighting
set mouse=a                 " enable mouse click
set clipboard=unnamedplus   " using system clipboard
filetype plugin on
" set cursorline              " highlight current cursorline
set ttyfast                 " Speed up scrolling in Vim
" set spell                 " enable spell check (may need to download language package)
" set noswapfile            " disable creating swap file
" set backupdir=~/.cache/vim " Directory to store backup files.

hi NonText ctermbg=none guibg=NONE
hi Normal guibg=NONE ctermbg=NONE
hi NormalNC guibg=NONE ctermbg=NONE
hi SignColumn ctermbg=NONE ctermfg=NONE guibg=NONE

hi Pmenu ctermbg=NONE ctermfg=NONE guibg=NONE
hi FloatBorder ctermbg=NONE ctermfg=NONE guibg=NONE
hi NormalFloat ctermbg=NONE ctermfg=NONE guibg=NONE
hi TabLine ctermbg=None ctermfg=None guibg=None




]]
