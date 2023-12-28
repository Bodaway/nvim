require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all"
  ensure_installed = { "lua", "c_sharp","bash","typescript","css","dot","html","json","markdown","sql","yaml" },
    auto_install = true,
    highlight ={
      enable = true
    }
}