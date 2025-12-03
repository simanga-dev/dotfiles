vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
vim.keymap.set('n', '<leader>D', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })

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

vim.keymap.set('n', '<leader>dH', ':%diffget //2 <CR>')
vim.keymap.set('n', '<leader>dL', ':%diffget //3 <CR>')

vim.keymap.set('n', '<Esc>', ':nohlsearch<CR>')

vim.keymap.set('n', '<leader>A', ':!launch-agent.sh<CR>', { desc = 'Lauch agentic coding for this folder' })

vim.keymap.set('n', '<leader>S', ':%s/\\<<C-R><C-W>\\>/<C-R>0/g<CR>')

vim.keymap.set('t', '<C-\\><C-\\>', '<C-\\><C-n>')
vim.keymap.set('t', '<Esc>', '<C-\\><C-n>')

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'snacks_terminal', -- Replace 'lua' with your desired file type
  callback = function()
    vim.keymap.set('t', '<C-_>', function()
      vim.api.nvim_input '<C-\\><C-n>'
      Snacks.terminal()
    end, { buffer = true }) -- Local to buffer
  end,
})

-- vim.keymap.set('n', '<leader>.', ':e<space>**/')
vim.keymap.set('n', '<leader>M', ':wa<CR>:make<CR>')
-- vim.keymap.set('n', '<leader>cr', ':wa<CR>:!cargo run <CR>')
-- vim.keymap.set('n', '<leader>ct', ':wa<CR>:!cargo test <CR>')

-- Managing buffers and Windows
vim.keymap.set('n', '<leader>B', ':bdelete!<CR>')
-- vim.keymap.set('n', '<leader>>', ':bn<CR>')
-- vim.keymap.set('n', '<leader><', ':bp<CR>')
-- vim.keymap.set('n', '<leader>.', ':cnext<CR>')
-- vim.keymap.set('n', '<leader>,', ':cprevious<CR>')

vim.keymap.set('n', '<leader>q', ':close<CR>')

vim.keymap.set('n', '<leader>Q', ':tabc<CR>')
vim.keymap.set('n', '<leader><CR>', ':only<CR>')
-- vim.keymap.set("n", "<leader>O", ":unhide<CR>")
vim.keymap.set('n', '<leader>_', ':res<CR>')
vim.keymap.set('n', '}', '}w0')
vim.keymap.set('n', '{', '{b0')
-- vim.keymap.set("n", "<leader>|", ":vert res<CR>")
--
--
vim.api.nvim_set_keymap('n', '<S-ScrollWheelLeft>', '<Cmd>execute("vertical scroll +1")<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<S-ScrollWheelRight>', '<Cmd>execute("vertical scroll -1")<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '<S-ScrollWheelLeft>', '<Cmd>execute("vertical scroll +1")<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('i', '<S-ScrollWheelRight>', '<Cmd>execute("vertical scroll -1")<CR>', { noremap = true, silent = true })
