vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous [D]iagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic message' })
vim.keymap.set('n', '<leader>D', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })
-- vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })
-- vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
-- vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
-- vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
-- vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

vim.keymap.set('', '<Space>', '<Nop>')
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Line  Movementnnoremap <C-S-k> :YourCommandHere<CR>
vim.keymap.set('n', '<C-j>', ':t.<CR>')
vim.keymap.set('n', '<C-k>', ':t-1<CR>')
vim.keymap.set('v', '<C-j>', ":m '>+1<CR>gv=gv")
vim.keymap.set('v', '<C-k>', ":m '<-2<CR>gv=gv")

-- Diff get stafff
vim.keymap.set('n', '<leader>dh', ':diffget //2 <CR>')
vim.keymap.set('n', '<leader>dl', ':diffget //3 <CR>')

-- for some reason I need to save a lot since I am using oil.vim so better I have this
vim.keymap.set('n', '<leader>w', ':w <CR>')

vim.keymap.set('v', '<leader>f', ':!pg_format <CR>')

vim.keymap.set('v', '<leader>cl', ':CodeCompanion ')

-- My greates remap yet
vim.keymap.set('n', '<Esc>', ':nohlsearch<CR>')

-- -- format code based on a specific file type, use the LSP formnater if none
-- -- is mathch | asumem jq, black, prettier is installed on ypur machine
-- vim.keymap.set('n', '<space>F', function()
--     if vim.bo.filetype == 'json' then
--         vim.cmd('%!jq')
--     elseif vim.bo.filetype == 'python' then
--         vim.cmd('silent !black -q %')
--     elseif vim.bo.filetype == 'css'
--         and vim.bo.filetype == 'scss' then
--         vim.cmd('silent !prettier -w %')
--     -- elseif vim.bo.filetype == 'typescriptreact' then
--     --     vim.cmd('silent !prettier -w %')
--     else
--         vim.lsp.buf.format()
--     end
-- end)

-- vim.cmd(
--   [[
--     :set splitright
--     function! Exec_on_term(cmd)
--
--       if a:cmd=="normal"
--         exec "normal mk\"vyip"
--       else
--         exec "normal gv\"vy"
--       endif
--
--       if !exists("g:last_terminal_chan_id")
--         vs
--         terminal
--         let g:last_terminal_chan_id = b:terminal_job_id
--         wincmd p
--       endif
--
--       if getreg('"v') =~ "^\n"
--         call chansend(g:last_terminal_chan_id, expand("%:p")."\n")
--       else
--         call chansend(g:last_terminal_chan_id, @v)
--       endif
--       exec "normal `k"
--     endfunction
--
--     " nnoremap <space>r :call Exec_on_term("normal")<CR>
--     " vnoremap <space>r :<c-u>call Exec_on_term("visual")<CR>
-- ]]
-- )

-- format code based on a specific file type, use the LSP formnater if nonekey
-- is mathch | asumem jq, black, prettier is installed on ypur machine
-- vim.keymap.set('n', '<C-l>', ':set colorcolumn=80 <CR>')

-- vim.keymap.set('n', '<space>s', '<cmd>lua vim.diagnostic.setloclist()<CR>')

-- Supper Mapping to substitue// Degeration mapping
vim.keymap.set('n', '<leader>S', ':%s/\\<<C-R><C-W>\\>/<C-R>0/g<CR>')
vim.keymap.set('t', '<C-\\><C-\\>', '<C-\\><C-n>')
vim.keymap.set('t', '<C-\\>\\', '<C-\\><C-n>')
vim.keymap.set('n', '<leader>.', ':e<space>**/')
-- vim.keymap.set("n", "<leader>sT", ":tjump *")
vim.keymap.set('n', '<leader>M', ':wa<CR>:make<CR>')
vim.keymap.set('n', '<leader>cr', ':wa<CR>:!cargo run <CR>')
vim.keymap.set('n', '<leader>ct', ':wa<CR>:!cargo test <CR>')

-- Managing buffers and Windows
vim.keymap.set('n', '<leader>B', ':bdelete!<CR>')
vim.keymap.set('n', '<leader>>', ':bn<CR>')
vim.keymap.set('n', '<leader><', ':bp<CR>')
vim.keymap.set('n', '<leader>.', ':cnext<CR>')
vim.keymap.set('n', '<leader>,', ':cprevious<CR>')
vim.keymap.set('n', '<leader>q', ':close<CR>')
vim.keymap.set('n', '<leader>Q', ':tabc<CR>')
vim.keymap.set('n', '<leader><CR>', ':only<CR>')
-- vim.keymap.set("n", "<leader>O", ":unhide<CR>")
vim.keymap.set('n', '<leader>_', ':res<CR>')
vim.keymap.set('n', '}', '}w0')
vim.keymap.set('n', '{', '{b0')
-- vim.keymap.set("n", "<leader>|", ":vert res<CR>")
