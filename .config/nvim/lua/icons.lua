local M = {}

--- Diagnostic severities.
M.diagnostics = {
  ERROR = '',
  WARN = '',
  HINT = '',
  INFO = '',
}

--- For folding.
M.arrows = {
  right = '',
  left = '󰁍',
  up = '',
  down = '',
}

--- LSP symbol kinds.
M.symbol_kinds = {

  Array = '󰅪',
  Text = '',
  Method = '  ',
  Function = '  ',
  Constructor = '  ',
  Field = '󰜢',
  Variable = '  ',
  Class = '',
  Interface = '',
  Module = '',
  Property = '  ',
  Unit = '  ',
  Value = '  ',
  Enum = '  ',
  Keyword = '󰌋',
  Snippet = '',
  Color = '󰏘',
  File = '󰈙',
  Reference = '󰈇',
  Folder = '󰉋',
  EnumMember = '',
  Struct = '',
  Event = '',
  Operator = '󰆕',
  TypeParameter = '',

  -- Array = '󰅪',
  -- Class = '',
  -- Color = '󰏘',
  -- Constant = '󰏿',
  -- Constructor = '',
  -- Enum = '',
  -- EnumMember = '',
  -- Event = '',
  -- Field = '󰜢',
  -- File = '󰈙',
  -- Folder = '󰉋',
  -- Function = '󰆧',
  -- Interface = '',
  -- Keyword = '󰌋',
  -- Method = '󰆧',
  -- Module = '',
  -- Operator = '󰆕',
  -- Property = '󰜢',
  -- Reference = '󰈇',
  -- Snippet = '',
  -- Struct = '',
  -- Text = '',
  -- TypeParameter = '',
  -- Unit = '',
  -- Value = '',
  -- Variable = '󰀫',
}

--- Shared icons that don't really fit into a category.
M.misc = {
  bug = '',
  ellipsis = '…',
  git = '',
  search = '',
  vertical_bar = '│',
}

M.borders = {
  { '╭', 'FoldColumn' },
  { '─', 'FoldColumn' },
  { '╮', 'FoldColumn' },
  { '│', 'FoldColumn' },
  { '╯', 'FoldColumn' },
  { '─', 'FoldColumn' },
  { '╰', 'FoldColumn' },
  { '│', 'FoldColumn' },
}

M.symbols = {
  -- Change type
  added = '', -- or "✚", but this is redundant info if you use git_status_colors on the name
  modified = '', -- or "", but this is redundant info if you use git_status_colors on the name
  deleted = '', -- this can only be used in the git_status source
  renamed = '󰁕', -- this can only be used in the git_status source
  -- Status type
  untracked = '',
  ignored = '',
  unstaged = '',
  staged = '󰄬',
  conflict = '',
}
return M
