-- Telescope
local baseTelescope = require('telescope').setup {
    defaults = {
        file_ignore_patterns = {'node_modules', 'bin', 'obj'}
    }
}
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ts', builtin.find_files, {})
vim.keymap.set('n', '<leader>tg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>tb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})