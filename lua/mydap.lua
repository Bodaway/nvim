
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