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

vim.cmd [[colorscheme nvcode]]
--vim.cmd [[colorscheme meadow-nvim]]
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

    use {'williamboman/mason.nvim', "williamboman/mason-lspconfig.nvim"}
    use 'shaunsingh/nord.nvim'
    use 'christianchiarulli/nvcode-color-schemes.vim'
    use 'kuznetsss/meadow-nvim'
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
    --use {
    --     "akinsho/toggleterm.nvim",
    --     tag = '*'
    -- }
    -- use {
    --     "folke/trouble.nvim",
    --     requires = {"kyazdani42/nvim-web-devicons"}
    -- }

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

    use({
        "glepnir/lspsaga.nvim",
        branch = "main",
        config = function()
            require("lspsaga").setup({})
        end,
        requires = {{"nvim-tree/nvim-web-devicons"}}
    })
    use "ray-x/lsp_signature.nvim"

    use {
        'nvim-treesitter/nvim-treesitter',
        run = function()
            local ts_update = require('nvim-treesitter.install').update({
                with_sync = true
            })
            ts_update()
        end
    }
    use {"windwp/nvim-autopairs"}
    use {'norcalli/nvim-colorizer.lua'}
    use 'nvim-tree/nvim-web-devicons'

    use 'mfussenegger/nvim-treehopper'
    -- use 'sheerun/vim-polyglot'

end)

require('nvim-web-devicons').setup()
-- require("toggleterm").setup({
--     open_mapping = [[<c-t>]],
--     direction = "horizontal", -- vertical | horizontal | tab | float
--     persist_mode = true
-- })

require('gitsigns').setup()
require("mason").setup()
require("nvim-autopairs").setup {}
require('colorizer').setup()
require('mylspconfig')
-- luasnip setup
local luasnip = require 'luasnip'
require('mycmp')
require('mytelescope')
require('line')
require('mydap')
require('saga')
require'lsp_signature'.setup()
require('treesitter')
require('tree')
--require('mytrouble')

-- vim.g.nord_italic = false
-- require('nord').set()

require'meadow'.setup {
    -- Available options and default values
    color_saturation = 80, -- colors contrast, can be from 0 to 100
    color_value = 80, -- colors brightness, can be from 0 to 100
    indentblankline_colors = true, -- set colors for indent-blankline
    signify_colors = true, -- set colors for signify
    lspsaga_colors = true, -- set colors for lspsaga
    telescope_colors = true, -- set colors for telescope
    spelunker_colors = true, -- set colors for spelunker
    fixed_line_colors = true -- set colors for fixed_line
}

vim.cmd [[omap     <silent> m :<C-U>lua require('tsht').nodes()<CR>]]
vim.cmd [[xnoremap <silent> m :lua require('tsht').nodes()<CR>]]

