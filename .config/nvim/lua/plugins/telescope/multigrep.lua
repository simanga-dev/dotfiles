local pickers = require 'telescope.pickers'

local M = {}

local live_multigrep = function(opts)
  opts = opts or {}
  opts.cwd = opts.cwd or vim.uv.cwd()

  pickers.new(opts, {}):find()
end

M.setup = function()
  live_multigrep()
end

return M
