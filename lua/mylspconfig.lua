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
    -- vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
    vim.keymap.set('n', '<space>f', function()
        vim.lsp.buf.format {
            async = true
        }
    end, bufopts)

    if client.name == "omnisharp" then
        client.server_capabilities.semanticTokensProvider = {
            full = vim.empty_dict(),
            legend = {
                tokenModifiers = {"static_symbol"},
                tokenTypes = {"comment", "excluded_code", "identifier", "keyword", "keyword_control", "number",
                              "operator", "operator_overloaded", "preprocessor_keyword", "string", "whitespace", "text",
                              "static_symbol", "preprocessor_text", "punctuation", "string_verbatim",
                              "string_escape_character", "class_name", "delegate_name", "enum_name", "interface_name",
                              "module_name", "struct_name", "type_parameter_name", "field_name", "enum_member_name",
                              "constant_name", "local_name", "parameter_name", "method_name", "extension_method_name",
                              "property_name", "event_name", "namespace_name", "label_name",
                              "xml_doc_comment_attribute_name", "xml_doc_comment_attribute_quotes",
                              "xml_doc_comment_attribute_value", "xml_doc_comment_cdata_section",
                              "xml_doc_comment_comment", "xml_doc_comment_delimiter",
                              "xml_doc_comment_entity_reference", "xml_doc_comment_name",
                              "xml_doc_comment_processing_instruction", "xml_doc_comment_text",
                              "xml_literal_attribute_name", "xml_literal_attribute_quotes",
                              "xml_literal_attribute_value", "xml_literal_cdata_section", "xml_literal_comment",
                              "xml_literal_delimiter", "xml_literal_embedded_expression",
                              "xml_literal_entity_reference", "xml_literal_name", "xml_literal_processing_instruction",
                              "xml_literal_text", "regex_comment", "regex_character_class", "regex_anchor",
                              "regex_quantifier", "regex_grouping", "regex_alternation", "regex_text",
                              "regex_self_escaped_character", "regex_other_escape"}
            },
            range = true
        }
    end
end

local lsp_flags = {
    -- This is the default in Nvim 0.7+
    debounce_text_changes = 150
}

local pid = vim.fn.getpid()

require("mason").setup()
require("mason-lspconfig").setup({
    ensure_installed = {"tsserver", "bicep", "omnisharp", "bashls", "luau_lsp", "sqlls", "yamlls", "lua_ls",
                        "marksman", "jsonls"}
})

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
    require"lsp_signature".on_attach({}, bufnr)
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
lspconfig['lua_ls'].setup {
    capabilities = capabilities,
    on_attach = on_attach,
    flags = lsp_flags
}
lspconfig['marksman'].setup {
    capabilities = capabilities,
    on_attach = on_attach,
    flags = lsp_flags
}
lspconfig['bicep'].setup {
    capabilities = capabilities,
    on_attach = on_attach,
    flags = lsp_flags
}
lspconfig['jsonls'].setup {
    capabilities = capabilities,
    on_attach = on_attach,
    flags = lsp_flags
}
-- vim.lsp.set_log_level 'debug'
-- require('vim.lsp.log').set_format_func(vim.inspect)
