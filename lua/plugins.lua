local on_windows = vim.loop.os_uname().version:match 'Windows'

local omnisharp_bin
local bicep_lsp_bin
local netcoredbg_path

if on_windows then
    omnisharp_bin = 'C:\\Users\\MichelBonenfant\\AppData\\Local\\nvim-data\\mason\\packages\\omnisharp\\OmniSharp.dll'
    bicep_lsp_bin =
        "C:\\Users\\MichelBonenfant\\AppData\\Local\\nvim-data\\mason\\packages\\bicep-lsp\\bicepLanguageServer\\Bicep.LangServer.dll"

else
    omnisharp_bin = '/home/bod/.local/share/nvim/mason/packages/omnisharp/OmniSharp.dll'
    netcoredbg_path = '/home/bod/.local/share/nvim/mason/packages/omnisharp'
    bicep_lsp_bin = "/home/bod/.local/share/nvim/mason/packages/bicep_lsp/bicepLanguageServer/Bicep.LangServer.dll"
end

-- disable netrw at the very start of your init.lua (strongly advised)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true

vim.g.mapleader = '$'
require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    use {'scrooloose/nerdtree'}

    use {'williamboman/mason.nvim'}
    use 'shaunsingh/nord.nvim'
    use 'neovim/nvim-lspconfig'
    use 'Hoffs/omnisharp-extended-lsp.nvim'

    use {
        "hrsh7th/nvim-cmp",
        requires = {"hrsh7th/cmp-buffer", "hrsh7th/cmp-nvim-lsp", 'L3MON4D3/LuaSnip', 'saadparwaiz1/cmp_luasnip',
                    'hrsh7th/cmp-nvim-lua', 'octaltree/cmp-look', 'hrsh7th/cmp-path', 'hrsh7th/cmp-calc',
                    'f3fora/cmp-spell', 'hrsh7th/cmp-emoji'}
    }
    use {
        'nvim-telescope/telescope.nvim',
        requires = {{'nvim-lua/plenary.nvim'}}
    }
    use {
        'nvim-lualine/lualine.nvim',
        requires = {
            'kyazdani42/nvim-web-devicons',
            opt = true
        }
    }

    use {
        "kyoz/purify",
        run = 'vim'
    }

    use {'tpope/vim-fugitive'}
    use {
        'junegunn/gv.vim',
        opt = true,
        cmd = {'GV'}
    } -- Git log graphical visualisation
    use 'arkav/lualine-lsp-progress'

    use('tpope/vim-repeat')

    use { -- gitsigns.nvim
    'lewis6991/gitsigns.nvim'}
    use {
        "akinsho/toggleterm.nvim",
        tag = '*'
    }
    use {
        "folke/trouble.nvim",
        requires = {"kyazdani42/nvim-web-devicons"}
    }

    use {
        'mfussenegger/nvim-dap',
        requires = {'rcarriga/nvim-dap-ui', 'theHamsta/nvim-dap-virtual-text'}
    }

    use 'ravenxrz/DAPInstall.nvim'
    use {
        'nvim-tree/nvim-tree.lua',
        requires = {'nvim-tree/nvim-web-devicons' -- optional, for file icons
        },
        tag = 'nightly' -- optional, updated every week. (see issue #1193)
    }

    use {
        "glepnir/lspsaga.nvim",
        branch = "main"
    }
    use "ray-x/lsp_signature.nvim"

    use {
        'nvim-treesitter/nvim-treesitter',
        run = function()
            local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
            ts_update()
        end,
    }

end)

require("toggleterm").setup()
require('gitsigns').setup()
require("trouble").setup {
    position = "bottom", -- position of the list can be: bottom, top, left, right
    height = 10, -- height of the trouble list when position is top or bottom
    width = 50, -- width of the list when position is left or right
    icons = true, -- use devicons for filenames
    mode = "workspace_diagnostics", -- "workspace_diagnostics", "document_diagnostics", "quickfix", "lsp_references", "loclist"
    fold_open = "", -- icon used for open folds
    fold_closed = "", -- icon used for closed folds
    group = true, -- group results by file
    padding = true, -- add an extra new line on top of the list
    action_keys = { -- key mappings for actions in the trouble list
        -- map to {} to remove a mapping, for example:
        -- close = {},
        close = "q", -- close the list
        cancel = "<esc>", -- cancel the preview and get back to your last window / buffer / cursor
        refresh = "r", -- manually refresh
        jump = {"<cr>", "<tab>"}, -- jump to the diagnostic or open / close folds
        open_split = {"<c-x>"}, -- open buffer in new split
        open_vsplit = {"<c-v>"}, -- open buffer in new vsplit
        open_tab = {"<c-t>"}, -- open buffer in new tab
        jump_close = {"o"}, -- jump to the diagnostic and close the list
        toggle_mode = "m", -- toggle between "workspace" and "document" diagnostics mode
        toggle_preview = "P", -- toggle auto_preview
        hover = "K", -- opens a small popup with the full multiline message
        preview = "p", -- preview the diagnostic location
        close_folds = {"zM", "zm"}, -- close all folds
        open_folds = {"zR", "zr"}, -- open all folds
        toggle_fold = {"zA", "za"}, -- toggle fold of current file
        previous = "k", -- previous item
        next = "j" -- next item
    },
    indent_lines = true, -- add an indent guide below the fold icons
    auto_open = false, -- automatically open the list when you have diagnostics
    auto_close = false, -- automatically close the list when you have no diagnostics
    auto_preview = true, -- automatically preview the location of the diagnostic. <esc> to close preview and go back to last window
    auto_fold = false, -- automatically fold a file trouble list at creation
    auto_jump = {"lsp_definitions"}, -- for the given modes, automatically jump if there is only a single result
    signs = {
        -- icons / text used for a diagnostic
        error = "",
        warning = "",
        hint = "",
        information = "",
        other = "﫠"
    },
    use_diagnostic_signs = false -- enabling this will use the signs defined in your lsp client
}

require("mason").setup()
vim.cmd [[colorscheme purify]]

vim.lsp.set_log_level 'debug'
require('vim.lsp.log').set_format_func(vim.inspect)

-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = {
    noremap = true,
    silent = true
}
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, opts)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist, opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
    -- Enable completion triggered by <c-x><c-o>
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

    -- Mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local bufopts = {
        noremap = true,
        silent = true,
        buffer = bufnr
    }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
    vim.keymap.set('n', '<space>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, bufopts)
    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
    vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
    vim.keymap.set('n', '<space>f', function()
        vim.lsp.buf.format {
            async = true
        }
    end, bufopts)
end

local lsp_flags = {
    -- This is the default in Nvim 0.7+
    debounce_text_changes = 150
}

local pid = vim.fn.getpid()

-- Add additional capabilities supported by nvim-cmp
local capabilities = require("cmp_nvim_lsp").default_capabilities()
local lspconfig = require('lspconfig')

lspconfig['tsserver'].setup {
    capabilities = capabilities,
    on_attach = on_attach,
    flags = lsp_flags
}

vim.cmd [[ autocmd BufNewFile,BufRead *.bicep set filetype=bicep ]]
lspconfig['bicep'].setup {
    cmd = {"dotnet", bicep_lsp_bin},
    capabilities = capabilities,
    on_attach = on_attach,
    flags = lsp_flags, 
    require "lsp_signature".on_attach({}, bufnr),
}
local configOmnisharp = {
    handlers = {
        ["textDocument/definition"] = require('omnisharp_extended').handler
    },
    cmd = {'dotnet', omnisharp_bin},
    capabilities = capabilities,
    on_attach = on_attach
    -- useModernNet = true
    -- enable_roslyn_analyzers = true,
    -- analyze_open_documents_only = false
}
lspconfig['omnisharp'].setup(configOmnisharp)

vim.cmd [[ autocmd BufNewFile,BufRead *.azcli set filetype=sh ]]
lspconfig['bashls'].setup {
    filetypes = {"sh", "azcli"},
    capabilities = capabilities,
    on_attach = on_attach,
    flags = lsp_flags
}
lspconfig['luau_lsp'].setup {
    capabilities = capabilities,
    on_attach = on_attach,
    flags = lsp_flags
}
lspconfig['sqlls'].setup {
    capabilities = capabilities,
    on_attach = on_attach,
    flags = lsp_flags
}
lspconfig['yamlls'].setup {
    capabilities = capabilities,
    on_attach = on_attach,
    flags = lsp_flags
}
lspconfig['sumneko_lua'].setup {
    capabilities = capabilities,
    on_attach = on_attach,
    flags = lsp_flags
}

-- luasnip setup
local luasnip = require 'luasnip'

-- nvim-cmp setup
local cmp = require 'cmp'
cmp.setup {
    snippet = {
        expand = function(args)
            luasnip.lsp_expand(args.body)
        end
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<CR>'] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Replace,
            select = true
        },
        ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            else
                fallback()
            end
        end, {'i', 's'}),
        ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, {'i', 's'})
    }),
    sources = {{
        name = 'nvim_lsp'
    }, {
        name = 'luasnip'
    }}
}

-- Telescope
local baseTelescope = require('telescope').setup {
    defaults = {
        file_ignore_patterns = {'node_modules', 'bin', 'obj'}
    }
}
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})

require('line')

local dap, dapui, dap_virtual_text = require('dap'), require('dapui'), require('nvim-dap-virtual-text')

dapui.setup {}

dap.listeners.after.event_initialized['dapui_config'] = function()
    dapui.open()
end
dap.listeners.before.event_terminated['dapui_config'] = function()
    dapui.close()
end
dap.listeners.before.event_exited['dapui_config'] = function()
    dapui.close()
end

local dap_install = require("dap-install")

dap_install.setup({
    installation_path = "/home/bod/.local/share/nvim/dapinstall/"
})
dap_install.config("dnetcs")

dap_virtual_text.setup()

-- require('keymaps').dap()

dap.adapters.coreclr = {
    type = 'executable',
    command = netcoredbg_path,
    args = {'--interpreter=vscode'}
}

dap.configurations.cs = {{
    type = "coreclr",
    name = "launch - netcoredbg",
    request = "launch",
    program = function()
        return vim.fn.input('Path to dll', vim.fn.getcwd() .. '/bin/Debug/', 'file')
    end
}}

vim.fn.sign_define('DapBreakpoint', {
    text = '',
    texthl = 'DiagnosticDefaultError'
})
vim.fn.sign_define('DapBreakpointCondition', {
    text = '',
    texthl = 'DiagnosticDefaultError'
})
require("dapui").setup()

-- empty setup using defaults
require("nvim-tree").setup()

-- OR setup with some options
require("nvim-tree").setup({
    sort_by = "case_sensitive",
    open_on_setup = true,
    view = {
        adaptive_size = true,
        mappings = {
            list = {{
                key = "u",
                action = "dir_up"
            }}
        }
    },
    renderer = {
        group_empty = true
    },
    filters = {
        dotfiles = true
    }
})

local keymap = vim.keymap.set
local saga = require('lspsaga')

saga.init_lsp_saga()

-- Lsp finder find the symbol definition implement reference
-- if there is no implement it will hide
-- when you use action in finder like open vsplit then you can
-- use <C-t> to jump back
keymap("n", "gh", "<cmd>Lspsaga lsp_finder<CR>", {
    silent = true
})

-- Code action
keymap({"n", "v"}, "<leader>ca", "<cmd>Lspsaga code_action<CR>", {
    silent = true
})

-- Rename
keymap("n", "gr", "<cmd>Lspsaga rename<CR>", {
    silent = true
})

-- Peek Definition
-- you can edit the definition file in this flaotwindow
-- also support open/vsplit/etc operation check definition_action_keys
-- support tagstack C-t jump back
keymap("n", "gd", "<cmd>Lspsaga peek_definition<CR>", {
    silent = true
})

-- Show line diagnostics
keymap("n", "<leader>cd", "<cmd>Lspsaga show_line_diagnostics<CR>", {
    silent = true
})

-- Show cursor diagnostic
keymap("n", "<leader>cd", "<cmd>Lspsaga show_cursor_diagnostics<CR>", {
    silent = true
})

-- Diagnsotic jump can use `<c-o>` to jump back
keymap("n", "[e", "<cmd>Lspsaga diagnostic_jump_prev<CR>", {
    silent = true
})
keymap("n", "]e", "<cmd>Lspsaga diagnostic_jump_next<CR>", {
    silent = true
})

-- Only jump to error
keymap("n", "[E", function()
    require("lspsaga.diagnostic").goto_prev({
        severity = vim.diagnostic.severity.ERROR
    })
end, {
    silent = true
})
keymap("n", "]E", function()
    require("lspsaga.diagnostic").goto_next({
        severity = vim.diagnostic.severity.ERROR
    })
end, {
    silent = true
})

-- Outline
keymap("n", "<leader>o", "<cmd>LSoutlineToggle<CR>", {
    silent = true
})

-- Hover Doc
keymap("n", "K", "<cmd>Lspsaga hover_doc<CR>", {
    silent = true
})

-- Float terminal
keymap("n", "<A-d>", "<cmd>Lspsaga open_floaterm<CR>", {
    silent = true
})
-- if you want pass somc cli command into terminal you can do like this
-- open lazygit in lspsaga float terminal
keymap("n", "<A-d>", "<cmd>Lspsaga open_floaterm lazygit<CR>", {
    silent = true
})
-- close floaterm
keymap("t", "<A-d>", [[<C-\><C-n><cmd>Lspsaga close_floaterm<CR>]], {
    silent = true
})

require'lsp_signature'.setup() 

require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all"
  ensure_installed = { "lua", "c_sharp","bash","typescript" },
    auto_install = true,
}

-- local on_windows = vim.loop.os_uname().version:match 'Windows'

-- local function join_paths(...)
--     local path_sep = on_windows and '\\' or '/'
--     local result = table.concat({...}, path_sep)
--     return result
-- end

-- vim.cmd [[set runtimepath=$VIMRUNTIME]]

-- local temp_dir
-- local package_root

-- if on_windows then

--     temp_dir = 'C:\\Users\\MichelBonenfant\\AppData\\Local\\nvim-data'
--     vim.cmd('set packpath=' .. join_paths(temp_dir, 'site'))
--     package_root = join_paths(temp_dir, 'site', 'pack')

-- else
--     temp_dir = vim.loop.os_getenv 'TEMP' or '/tmp'
--     vim.cmd('set packpath=' .. join_paths(temp_dir, 'nvim', 'site'))
--     package_root = join_paths(temp_dir, 'nvim', 'site', 'pack')

-- end

-- local install_path = join_paths(package_root, 'packer', 'start', 'packer.nvim')
-- local compile_path = join_paths(install_path, 'plugin', 'packer_compiled.lua')

-- local function load_plugins()
--     require('packer').startup {{'wbthomason/packer.nvim', 'neovim/nvim-lspconfig', 'scrooloose/nerdtree',
--                                 'hrsh7th/cmp-nvim-lsp', 'hrsh7th/cmp-buffer', 'hrsh7th/cmp-path', 'hrsh7th/cmp-cmdline',
--                                 'hrsh7th/nvim-cmp', 'hrsh7th/cmp-vsnip', 'hrsh7th/vim-vsnip', 'williamboman/mason.nvim'} -- config = {
--     --     package_root = package_root,
--     --     compile_path = compile_path
--     -- }
--     }
-- end

-- local load_config = function()
--     require("mason").setup()

--     vim.lsp.set_log_level 'debug'
--     require('vim.lsp.log').set_format_func(vim.inspect)

--     local nvim_lsp = require 'lspconfig'
--     local capabilities = require('cmp_nvim_lsp').default_capabilities()

--     local pid = vim.fn.getpid()
--     local omnisharp_bin =
--         'C:\\Users\\MichelBonenfant\\AppData\\Local\\nvim-data\\mason\\packages\\omnisharp\\OmniSharp.exe'

--     -- Use an on_attach function to only map the following keys
--     -- after the language server attaches to the current buffer
--     local on_attach = function(client, bufnr)
--         -- Enable completion triggered by <c-x><c-o>
--         vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

--         -- Mappings.
--         -- See `:help vim.lsp.*` for documentation on any of the below functions
--         -- vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
--         -- vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
--         -- vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
--         -- vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
--         -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
--         -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
--         -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
--         -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>wl',
--         --     '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
--         -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
--         -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
--         -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
--         -- vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
--         -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
--     end

--     nvim_lsp['omnisharp'].setup {
--         capabilities = capabilities,
--         cmd = {omnisharp_bin, "--languageserver", "--hostPID", tostring(pid), "DotNet:enablePackageRestore=true"},
--         on_attach = on_attach,
--         useModernNet = true,
--         enable_roslyn_analyzers = true,
--         analyze_open_documents_only = false
--     }

--     local cmp = require 'cmp'
--     -- Global setup.
--     cmp.setup({
--         snippet = {
--             expand = function(args)
--                 vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
--                 -- require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
--                 -- require'snippy'.expand_snippet(args.body) -- For `snippy` users.
--                 -- vim.fn["UltiSnips#Anon"](args.body) -- For `ultisnips` users.
--             end
--         },
--         window = {
--             -- completion = cmp.config.window.bordered(),
--             -- documentation = cmp.config.window.bordered(),
--         },
--         mapping = cmp.mapping.preset.insert({
--             ['<C-d>'] = cmp.mapping.scroll_docs(-4),
--             ['<C-f>'] = cmp.mapping.scroll_docs(4),
--             ['<C-Space>'] = cmp.mapping.complete(),
--             ['<CR>'] = cmp.mapping.confirm({
--                 select = true
--             })
--         }),
--         sources = cmp.config.sources({{
--             name = 'nvim_lsp'
--         }})
--     })
-- end

-- if vim.fn.isdirectory(install_path) == 0 then
--     vim.fn.system {'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path}
--     load_plugins()
--     require('packer').sync()
--     local packer_group = vim.api.nvim_create_augroup('Packer', {
--         clear = true
--     })
--     vim.api.nvim_create_autocmd('User', {
--         pattern = 'PackerComplete',
--         callback = load_config,
--         group = packer_group,
--         once = true
--     })
-- else
--     load_plugins()
--     require('packer').sync()
--     load_config()
-- end
