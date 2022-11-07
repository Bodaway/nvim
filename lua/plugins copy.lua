return require('packer').startup(function()
    use 'wbthomason/packer.nvim' -- so packer can update itself
    -- use { -- nice interface for LSP functions (among other things)
    --     'nvim-telescope/telescope.nvim',
    --     requires = {{'nvim-lua/plenary.nvim'}}
    -- }
    -- use 'neovim/nvim-lspconfig' -- native LSP support
    -- use 'hrsh7th/nvim-cmp' -- autocompletion framework
    -- use 'kyazdani42/nvim-tree.lua'
    -- use 'williamboman/nvim-lsp-installer'
     use 'scrooloose/nerdtree'
    -- -- use 'OmniSharp/omnisharp-vim'
    -- use 'hrsh7th/cmp-nvim-lsp'
    -- use 'hrsh7th/cmp-buffer'
    -- use 'hrsh7th/cmp-path'
    -- use 'hrsh7th/cmp-cmdline'
    -- use 'hrsh7th/nvim-cmp'
    -- use 'hrsh7th/cmp-vsnip'
    -- use 'hrsh7th/vim-vsnip'

end)

-- -- Set up nvim-cmp.
-- local cmp = require 'cmp'

-- cmp.setup({
--     formatting = {
--         format = function(entry, vim_item)
--             -- Source
--             vim_item.menu = ({
--                 buffer = "[Buffer]",
--                 nvim_lsp = "[LSP]",
--                 luasnip = "[LuaSnip]",
--                 nvim_lua = "[Lua]",
--                 latex_symbols = "[LaTeX]"
--             })[entry.source.name]
--             return vim_item
--         end
--     },
--     sources = cmp.config.sources({{
--         name = 'nvim_lsp'
--     }})
-- })

-- local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- require("nvim-lsp-installer").setup {}
-- local lspconfig = require("lspconfig")

-- local function on_attach(client, bufnr)
--     -- set up buffer keymaps, etc.
-- end

-- lspconfig.omnisharp.setup {
--     on_attach = on_attach,
--     capabilities = capabilities,
--     cmd = {"dotnet", "/home/bod/.local/share/nvim/lsp_servers/omnisharp/omnisharp/OmniSharp.dll"},

--     -- Enables support for reading code style, naming convention and analyzer
--     -- settings from .editorconfig.
--     enable_editorconfig_support = true,

--     -- If true, MSBuild project system will only load projects for files that
--     -- were opened in the editor. This setting is useful for big C# codebases
--     -- and allows for faster initialization of code navigation features only
--     -- for projects that are relevant to code that is being edited. With this
--     -- setting enabled OmniSharp may load fewer projects and may thus display
--     -- incomplete reference lists for symbols.
--     enable_ms_build_load_projects_on_demand = false,

--     -- Enables support for roslyn analyzers, code fixes and rulesets.
--     enable_roslyn_analyzers = true,

--     -- Specifies whether 'using' directives should be grouped and sorted during
--     -- document formatting.
--     organize_imports_on_format = false,

--     -- Enables support for showing unimported types and unimported extension
--     -- methods in completion lists. When committed, the appropriate using
--     -- directive will be added at the top of the current file. This option can
--     -- have a negative impact on initial completion responsiveness,
--     -- particularly for the first few completion sessions after opening a
--     -- solution.
--     enable_import_completion = true,

--     -- Specifies whether to include preview versions of the .NET SDK when
--     -- determining which version to use for project loading.
--     sdk_include_prereleases = true,

--     -- Only run analyzers against open files when 'enableRoslynAnalyzers' is
--     -- true
--     analyze_open_documents_only = false
-- }
-- lspconfig.tsserver.setup {
--     on_attach = on_attach
-- }

-- -- local capabilities = vim.lsp.protocol.make_client_capabilities()
-- -- capabilities = require('cmp_nvim_lsp').default_capabilities()

-- -- -- nvim-cmp
-- -- local cmp = require('cmp')
-- -- cmp.setup({
-- --     snippet = {
-- --         expand = function(args)
-- --             vim.fn["vsnip#anonymous"](args.body)
-- --         end,
-- --     },
-- --     preselect = cmp.PreselectMode.None,
-- --     mapping = {
-- --         ['<C-j>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
-- --         ['<Tab>'] = cmp.mapping(function(fallback)
-- --             if cmp.visible() then
-- --                 cmp.select_next_item()
-- --             else
-- --                 fallback()
-- --             end
-- --         end),
-- --         ['<S-Tab>'] = cmp.mapping(function()
-- --             if cmp.visible() then
-- --                 cmp.select_prev_item()
-- --             end
-- --         end)
-- --     },
-- --     sources = {
-- --         { name = "nvim_lsp" },
-- --         { name = "vsnip" },
-- --         { name = "buffer" }
-- --     }
-- -- })