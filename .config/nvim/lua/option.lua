vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

local function trim_trailing_whitespaces()
  if
    vim.bo.modifiable == true
    and vim.bo.filetype ~= 'TelescopePrompt'
    and vim.bo.filetype ~= 'octo'
    and vim.bo.filetype ~= 'dap-repl'
    and vim.bo.filetype ~= 'bout'
    and vim.bo.filetype ~= 'oil'
    and vim.bo.filetype ~= 'neo-tree-popup'
  then
    local view = vim.fn.winsaveview()
    vim.cmd [[keep %s/\s\+$//e]]
    vim.cmd 'update'
    vim.fn.winrestview(view)
  end
  -- vim.cmd([[let @/ = '']])
end

local function term_config()
  if vim.bo.buftype == 'terminal' then
    vim.wo.number = false
    vim.wo.relativenumber = false
    -- vim.cmd [[ startinsert ]]
  else
    -- vim.wo.number = true
    -- vim.wo.relativenumber = true
    trim_trailing_whitespaces()
  end
end

-- Super cool, works DiffviewFiles perfect.... I am proud of myself
local group_1 = vim.api.nvim_create_augroup('hide-numbers', { clear = true })
vim.api.nvim_create_autocmd('BufEnter', {
  callback = function()
    if
      vim.bo.buftype == 'terminal'
      or vim.bo.filetype == 'markdown'
      or vim.bo.filetype == ''
      or vim.bo.filetype == 'gitcommit'
      or vim.bo.filetype == 'chatgpt-input'
      or vim.bo.filetype == 'oil'
      or vim.bo.filetype == 'neo-tree'
    then
      vim.wo.number = false
      vim.wo.relativenumber = false
      vim.o.wrap = true
      vim.o.textwidth = 80
      -- vim.cmd [[ startinsert ]]
    elseif
      vim.bo.filetype == 'dbout'
      or vim.bo.filetype == 'dbui'
      or vim.bo.filetype == 'json'
      or vim.bo.filetype == 'qf'
      or vim.bo.filetype == 'httpResult'
      or vim.bo.filetype == 'DiffviewFiles'
      or vim.bo.filetype == 'git'
      or vim.bo.filetype == 'fugitiveblame'
      or vim.bo.filetype == 'OverseerList'
    then
      vim.wo.number = false
      vim.wo.relativenumber = false
      vim.o.wrap = false
      vim.o.textwidth = 80
    else
      vim.wo.number = true
      vim.wo.relativenumber = true
      vim.o.wrap = false
      vim.o.textwidth = 0
      -- trim_trailing_whitespaces()
    end
  end,
  group = group_1,
})

vim.api.nvim_create_autocmd('TermOpen', { callback = term_config, group = group_1 })

local group_2 = vim.api.nvim_create_augroup('auto-save', { clear = true })

vim.api.nvim_create_autocmd('FocusLost', { callback = trim_trailing_whitespaces, group = group_2 })

-- Highlight on yank
vim.cmd [[
  augroup YankHighlight
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank()
  augroup end
]]

-- Save as sudo...
vim.cmd [[
    cnoremap w!! execute 'silent! write !sudo tee % >/dev/null' <bar> edit!
]]

vim.cmd [[
    set spelllang=en
    set complete+=kspell
    augroup markdownSpell
        autocmd!
        autocmd FileType markdown setlocal spell
        autocmd BufLeave,WinLeave,FocusLost * silent! wa
        autocmd BufRead,BufNewFile *.md setlocal spell
        autocmd FileType gitcommit setlocal spell
        autocmd FileType gitcommit setlocal complete+=kspell
    augroup END


  autocmd BufNewFile,BufRead *.cshtml set filetype=html.cshtml.razor
  autocmd BufNewFile,BufRead *.razor set filetype=html.cshtml.razor

  autocmd BufNewFile,BufRead *.pcss set filetype=css

]]

-- [[ Setting options ]]
-- See `:help vim.opt`
-- NOTE: You can change these options as you wish!
--  For more options, you can see `:help option-list`

-- Make line numbers default
-- vim.opt.number = true
-- You can also add relative line numbers, for help with jumping.
--  Experiment for yourself to see if you like it!
-- vim.opt.relativenumber = true

-- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.mouse = 'a'
vim.opt.breakindent = true
vim.opt.updatetime = 250
vim.opt.timeoutlen = 300
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
vim.o.termguicolors = true
vim.o.completeopt = 'menu,menuone,noinsert'
vim.g.netrw_banner = 0
vim.o.inccommand = 'nosplit'
vim.o.hidden = true
vim.o.breakindent = true
vim.o.wrap = false
vim.cmd [[set undofile]]
vim.o.ignorecase = true
vim.o.smartcase = true
vim.opt.guicursor = ''
vim.opt.nu = true
vim.opt.relativenumber = true
vim.opt.errorbells = false
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv 'HOME' .. '/.vim/undodir'
vim.opt.undofile = true
vim.opt.incsearch = true
-- vim.o.showmode = false
vim.o.laststatus = 0
vim.o.showcmd = true
vim.opt.termguicolors = true
vim.o.pumheight = 8
-- vim.opt.scrolloff = 2
vim.opt.scrolloff = 2
vim.opt.signcolumn = 'yes'
vim.opt.hlsearch = true
vim.opt.cursorline = true
vim.opt.clipboard = 'unnamedplus'
-- vim.opt.isfname:append("@-@")
-- vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"

-- Give more space for displaying messages.
-- vim.opt.cmdheight = 1

-- Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
-- delays and poor user experience.
vim.opt.updatetime = 50
-- Don't pass messages to |ins-completion-menu|.
vim.opt.shortmess:append 'c'
-- vim.opt.colorcolumn = "80"

vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, { border = 'rounded' })

vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = 'rounded' })

vim.diagnostic.config {
  float = { source = 'always', border = 'rounded' },
  signs = false,
  severity_sort = true,
}
