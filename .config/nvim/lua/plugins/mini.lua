return { -- Collection of various small independent plugins/modules
  'echasnovski/mini.nvim',
  dependencies = { 'nvim-treesitter/nvim-treesitter-textobjects' },
  config = function()
    -- Better Around/Inside textobjects
    --
    -- Examples:
    --  - va)  - [V]isually select [A]round [)]paren
    --  - yinq - [Y]ank [I]nside [N]ext [']quote
    --  - ci'  - [C]hange [I]nside [']quote

    local spec_treesitter = require('mini.ai').gen_spec.treesitter
    require('mini.ai').setup {

      n_lines = 500,
      custom_textobjects = {
        a = spec_treesitter { a = '@parameter.outer', i = '@parameter.inner' },
        c = spec_treesitter { a = '@class.outer', i = '@class.inner' },
        f = spec_treesitter { a = '@function.outer', i = '@function.inner' },
        F = spec_treesitter { a = '@call.outer', i = '@call.inner' },
        o = spec_treesitter {
          a = { '@block.outer', '@conditional.outer', '@loop.outer' },
          i = { '@block.inner', '@conditional.inner', '@loop.inner' },
        },
      },
    }

    -- Add/delete/replace surroundings (brackets, quotes, etc.)
    --
    -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
    -- - sd'   - [S]urround [D]elete [']quotes
    -- - sr)'  - [S]urround [R]eplace [)] [']
    require('mini.surround').setup()

    require('mini.pairs').setup()

    -- Simple and easy statusline.
    --  You could remove this setup call if you don't like it,
    --  and try some other statusline plugin
    -- local statusline = require 'mini.statusline'
    -- statusline.setup()

    -- You can configure sections in the statusline by overriding their
    -- default behavior. For example, here we disable the section for
    -- cursor information because line numbers are already enabled
    ---@diagnostic disable-next-line: duplicate-set-field
    -- statusline.section_location = function()
    --   return ''
    -- end

    -- ... and there is more!
    --  Check out: https://github.com/echasnovski/mini.nvim
  end,
}
