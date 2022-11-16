local on_windows = vim.loop.os_uname().version:match 'Windows'

local omnisharp_bin
local bicep_lsp_bin

if on_windows then
    omnisharp_bin = 'C:\\Users\\MichelBonenfant\\AppData\\Local\\nvim-data\\mason\\packages\\omnisharp\\OmniSharp.dll'
    bicep_lsp_bin =
        "C:\\Users\\MichelBonenfant\\AppData\\Local\\nvim-data\\mason\\packages\\bicep-lsp\\bicepLanguageServer\\Bicep.LangServer.dll"

else
    omnisharp_bin = '/home/bod/.local/share/nvim/mason/packages/omnisharp/OmniSharp.dll'
    bicep_lsp_bin = "/home/bod/.local/share/nvim/mason/packages/bicep_lsp/bicepLanguageServer/Bicep.LangServer.dll"
end


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
    on_attach = on_attach,
    useModernNet = true,
    enable_roslyn_analyzers = true
    -- analyze_open_documents_only = false
}
lspconfig['omnisharp'].setup(configOmnisharp)

-- lspconfig['csharp_ls'].setup{
--     capabilities = capabilities,
--     on_attach = on_attach,
-- }

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
