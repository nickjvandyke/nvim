-- Clear highlights on search when pressing <Esc> in normal mode
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Keybinds to make split navigation easier.
-- Eh idk. Valuable keys.
-- vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
-- vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
-- vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
-- vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })
-- vim.keymap.set('n', '<C-q>', '<C-w><C-q>', { desc = 'Close current window' })

vim.keymap.set({ 'n', 'v' }, 'H', '^', { desc = 'Move to the beginning of the line' })
vim.keymap.set({ 'n', 'v' }, 'L', '$', { desc = 'Move to the end of the line' })

vim.keymap.set('n', '<C-w>+', '<cmd>resize +7<cr>', { desc = 'Increase Window Height', silent = true })
vim.keymap.set('n', '<C-w>-', '<cmd>resize -7<cr>', { desc = 'Decrease Window Height', silent = true })
vim.keymap.set('n', '<C-w>>', '<cmd>vertical resize +7<cr>', { desc = 'Increase Window Width', silent = true })
vim.keymap.set('n', '<C-w><', '<cmd>vertical resize -7<cr>', { desc = 'Decrease Window Width', silent = true })

vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv", { desc = 'Move selected lines down', silent = true })
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv", { desc = 'Move selected lines up', silent = true })

-- This is almost always my preferred behavior
vim.keymap.set('x', 'p', '"_dP', { desc = 'Paste over selection without yanking' })

vim.keymap.set('n', 'y\\', function()
  -- -n means do not append newline
  vim.cmd [[ silent !echo -n %:. | pbcopy ]]
  vim.notify('Copied: ' .. vim.fn.expand '%:.')
end, { desc = 'Copy relative filepath to clipboard' })

-- Mapped in quicker.lua
-- vim.keymap.set('n', '<leader>qf', '<cmd>copen<cr>', { desc = 'QuickFix list' })
-- vim.keymap.set('n', '<leader>ql', '<cmd>lopen<cr>', { desc = 'Location list' })

vim.keymap.set('n', 'grN', [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/g<Left><Left>]], { desc = 'Replace word under cursor' })

vim.keymap.set('n', 'gG', 'gg<S-v>G', { desc = 'Select all' })

vim.keymap.set('n', '<C-c>', 'ciw')

vim.keymap.set('n', '<C-s>', '<cmd>wall<cr>', { desc = 'Save all buffers', silent = true })

vim.keymap.set('n', '+', '<C-a>', { desc = 'Increment number under cursor', noremap = true })
vim.keymap.set('n', '-', '<C-x>', { desc = 'Decrement number under cursor', noremap = true })

vim.keymap.set('n', '<C-q>', '<cmd>qall<cr>', { desc = 'Save + Quit Neovim', silent = true })

-- g?: Web search
vim.keymap.set('n', 'g??', function()
  vim.ui.open(('https://google.com/search?q=%s'):format(vim.fn.expand '<cword>'))
end, { desc = 'Google search word under cursor' })
vim.keymap.set('x', 'g??', function()
  vim.ui.open(
    ('https://google.com/search?q=%s'):format(vim.trim(table.concat(vim.fn.getregion(vim.fn.getpos '.', vim.fn.getpos 'v', { type = vim.fn.mode() }), ' ')))
  )
  vim.api.nvim_input '<esc>'
end, { desc = 'Google search selected text' })
