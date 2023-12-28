local netcoredbg_path = '/home/bod/.local/share/nvim/dapinstall/dnetcs/netcoredbg/netcoredbg'

local dap, dapui, dap_virtual_text = require('dap'), require('dapui'), require('nvim-dap-virtual-text')
-- dapui.setup {}

-- dap.listeners.after.event_initialized['dapui_config'] = function()
--     dapui.open()
-- end
-- dap.listeners.before.event_terminated['dapui_config'] = function()
--     dapui.close()
-- end
-- dap.listeners.before.event_exited['dapui_config'] = function()
--     dapui.close()
-- end

local dap_install = require("dap-install")

  require("nvim-dap-virtual-text").setup {
    commented = true,
  }

  local dap, dapui = require "dap", require "dapui"
  dapui.setup {} -- use default
  dap.listeners.after.event_initialized["dapui_config"] = function()
    dapui.open()
  end
  dap.listeners.before.event_terminated["dapui_config"] = function()
    dapui.close()
  end
  dap.listeners.before.event_exited["dapui_config"] = function()
    dapui.close()
  end

dap_install.setup({
    installation_path = "/home/bod/.local/share/nvim/dapinstall/"
})
dap_install.config("dnetcs")

--dap_virtual_text.setup()

-- require('keymaps').dap()

dap.adapters.coreclr = {
    type = 'executable',
    command = netcoredbg_path,
    args = {'--interpreter=vscode'}
}

dap.configurations.cs = {{
    name = "Attach to process",
    type = 'coreclr',
    request = 'attach',
    -- TODO: I _think_ the process could be found automatically using a similar method to the automatic
    processId = require('dap.utils').pick_process
    --args = {}
  }}

-- dap.configurations.cs = {{
--     type = "coreclr",
--     name = "launch - netcoredbg",
--     request = "launch",
--     program = function()
--         return vim.fn.input('Path to dll: ', vim.fn.getcwd() .. '', 'file')
--     end
    
    -- function()
    --     return vim.fn.input('Path to dll', vim.fn.getcwd() .. '/bin/Debug/net6.0/', 'file')
    -- end
-- }}

vim.fn.sign_define('DapBreakpoint', {
    text = '',
    texthl = 'DiagnosticDefaultError'
})
vim.fn.sign_define('DapBreakpointCondition', {
    text = '',
    texthl = 'DiagnosticDefaultError'
})

vim.keymap.set('n', '<leader>dk', function() require('dap').continue() end)
vim.keymap.set('n', '<leader>dl', function() require('dap').run_last() end)
vim.keymap.set('n', '<leader>b', function() require('dap').toggle_breakpoint() end)

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
        dotfiles = false
    },
    git = {
      ignore = false
    }
})