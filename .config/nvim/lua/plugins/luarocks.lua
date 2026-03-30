return {
  'vhyrro/luarocks.nvim',
  priority = 1000,
  config = true,
  opts = {
    rocks = { 'dkjson' }, -- Required dependency for luarocks
    -- luarocks_build_args = { "--with-lua=/my/path" }, -- extra options to pass to luarocks's configuration script
  },
  build = 'rocks install dkjson', -- Ensure dkjson is installed during build
}
