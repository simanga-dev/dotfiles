return {
  'vhyrro/luarocks.nvim',
  priority = 1000,
  config = true,
  opts = {
    -- rocks = { 'fzy', 'pathlib.nvim ~> 1.0' }, -- specifies a list of rocks to install
    -- luarocks_build_args = { "--with-lua=/my/path" }, -- extra options to pass to luarocks's configuration script
  },
}
