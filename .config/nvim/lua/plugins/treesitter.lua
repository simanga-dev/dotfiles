local function set_generate_args()
  local install = require 'nvim-treesitter.install'

  if vim.treesitter.language_version then
    install.ts_generate_args = { 'generate', '--abi', tostring(vim.treesitter.language_version) }
  else
    install.ts_generate_args = { 'generate' }
  end
end

return {
  'nvim-treesitter/nvim-treesitter',
  branch = 'main',
  build = ':TSUpdate',
  lazy = false,
  init = set_generate_args,
  config = function()
    set_generate_args()
    require('nvim-treesitter').setup()

    local group = vim.api.nvim_create_augroup('dotfiles-treesitter', { clear = true })
    vim.api.nvim_create_autocmd('FileType', {
      group = group,
      callback = function(args)
        if vim.bo[args.buf].buftype ~= '' then
          return
        end

        local ok = pcall(vim.treesitter.start, args.buf)
        if not ok then
          return
        end

        vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      end,
    })

    vim.keymap.set('n', 'gn', 'van', { remap = true, desc = 'Expand treesitter selection' })
    vim.keymap.set('x', 'gn', 'an', { remap = true, desc = 'Expand treesitter selection' })
    vim.keymap.set('x', 'gN', 'in', { remap = true, desc = 'Shrink treesitter selection' })
  end,
}
