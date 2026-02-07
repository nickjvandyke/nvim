vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

vim.api.nvim_create_autocmd('CursorHold', {
  desc = 'Trigger autoread (in case file changed externally)',
  callback = function()
    vim.cmd 'checktime'
  end,
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'markdown',
  desc = 'Set wrap for markdown files',
  callback = function()
    vim.wo.wrap = true
  end,
})

vim.api.nvim_create_autocmd('BufReadPost', {
  desc = 'Restore cursor to file position in previous editing session',
  callback = function(args)
    local mark = vim.api.nvim_buf_get_mark(args.buf, '"')
    local line_count = vim.api.nvim_buf_line_count(args.buf)
    if mark[1] > 0 and mark[1] <= line_count then
      vim.cmd 'normal! g`"zz'
    end
  end,
})

-- cmdheight-peek
local cmdGrp = vim.api.nvim_create_augroup('cmdline_height', { clear = true })
local function set_cmdheight(val)
  if vim.opt.cmdheight:get() ~= val then
    vim.opt.cmdheight = val
    vim.cmd.redrawstatus()
  end
end

vim.api.nvim_create_autocmd('CmdlineEnter', {
  group = cmdGrp,
  callback = function()
    set_cmdheight(1)
  end,
})

vim.api.nvim_create_autocmd('CmdlineLeave', {
  group = cmdGrp,
  callback = function()
    set_cmdheight(0)
  end,
})

vim.api.nvim_create_autocmd('TermOpen', {
  pattern = '*',
  command = 'setlocal nonumber norelativenumber signcolumn=no',
})
