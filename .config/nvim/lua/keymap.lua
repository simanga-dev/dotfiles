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

vim.keymap.set('x', '<leader>dh', ":'<,'>diffget //2<CR>", { silent = true })
vim.keymap.set('x', '<leader>dl', ":'<,'>diffget //3<CR>", { silent = true })

vim.keymap.set('n', '<leader>dH', ':%diffget //2 <CR>')
vim.keymap.set('n', '<leader>dL', ':%diffget //3 <CR>')

vim.keymap.set('n', '<Esc>', ':nohlsearch<CR>')

vim.keymap.set('n', '<leader>A', ':!launch-agent.sh<CR>', { desc = 'Lauch agentic coding for this folder' })

vim.keymap.set('n', '<leader>S', ':%s/\\<<C-R><C-W>\\>/<C-R>0/g<CR>')

vim.keymap.set('t', '<C-\\><C-\\>', '<C-\\><C-n>')
vim.keymap.set('t', '<leader><Esc>', '<C-\\><C-n>')

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'snacks_terminal', -- Replace 'lua' with your desired file type
  callback = function()
    vim.keymap.set('t', '<C-_>', function()
      vim.api.nvim_input '<C-\\><C-n>'
      Snacks.terminal()
    end, { buffer = true }) -- Local to buffer
  end,
})

vim.keymap.set('n', '<leader>mp', function()
  vim.fn.jobstart({ 'tatum', 'serve', '--open', vim.fn.expand '%' }, { noremap = true, silent = true })
end)

vim.keymap.set('n', '<C-c>', ':r !lumen draft<CR>')

-- vim.keymap.set('n', '<leader>cr', ':wa<CR>:!cargo run <CR>')
-- vim.keymap.set('n', '<leader>ct', ':wa<CR>:!cargo test <CR>')
vim.keymap.set('n', '<leader>M', ':make <CR>')
--

vim.keymap.set('v', '<leader>r', ':!bash <CR>') -- this might be my best mapping evere

-- Managing buffers and Windows
vim.keymap.set('n', '<leader>B', ':bdelete!<CR>')
-- vim.keymap.set('n', '<leader>>', ':bn<CR>')
-- vim.keymap.set('n', '<leader><', ':bp<CR>')
-- vim.keymap.set('n', '<leader>.', ':cnext<CR>')
-- vim.keymap.set('n', '<leader>,', ':cprevious<CR>')

vim.api.nvim_create_user_command('HackerNews', function()
  local url = 'https://hacker-news.firebaseio.com/v0/topstories.json'
  local ids = vim.fn.json_decode(vim.fn.system('curl -s ' .. url))
  local lines = { '# Hacker News Top 10', '' }
  for i = 1, 10 do
    local story_url = 'https://hacker-news.firebaseio.com/v0/item/' .. ids[i] .. '.json'
    local story = vim.fn.json_decode(vim.fn.system('curl -s ' .. story_url))
    table.insert(lines, i .. '. [' .. story.title .. '](' .. (story.url or ('https://news.ycombinator.com/item?id=' .. story.id)) .. ')')
  end
  vim.cmd 'new'
  vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)
  vim.bo.buftype = 'nofile'
  vim.bo.bufhidden = 'wipe'
  vim.bo.swapfile = false
  vim.bo.modifiable = false
  vim.bo.filetype = 'markdown'
end, {})

vim.api.nvim_create_user_command('GitHubTrending', function()
  local url = 'https://api.github.com/search/repositories?q=created:>'
    .. os.date('%Y-%m-%d', os.time() - 7 * 24 * 60 * 60)
    .. '&sort=stars&order=desc&per_page=10'
  local result = vim.fn.system('curl -s -H "Accept: application/vnd.github.v3+json" "' .. url .. '"')
  local data = vim.fn.json_decode(result)
  local lines = { '# GitHub Trending (Past Week)', '' }
  for i, repo in ipairs(data.items or {}) do
    table.insert(lines, i .. '. [' .. repo.full_name .. '](' .. repo.html_url .. ') ⭐ ' .. repo.stargazers_count)
    table.insert(lines, '   ' .. (repo.description or 'No description'))
    table.insert(lines, '')
  end
  vim.cmd 'new'
  vim.api.nvim_buf_set_lines(0, 0, -1, false, lines)
  vim.bo.buftype = 'nofile'
  vim.bo.bufhidden = 'wipe'
  vim.bo.swapfile = false
  vim.bo.modifiable = false
  vim.bo.filetype = 'markdown'
end, {})

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
