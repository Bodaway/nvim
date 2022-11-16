require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all"
  ensure_installed = { "lua", "c_sharp","bash","typescript" },
    auto_install = true,
}