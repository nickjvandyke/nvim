-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.opt.winborder = 'rounded'

vim.g.winblend_default = 0 --20

-- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.mouse = 'a'

-- Don't show the mode, since it's already in the status line
vim.opt.showmode = false

-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.schedule(function()
  vim.opt.clipboard = 'unnamedplus'
end)

vim.opt.linebreak = true
vim.opt.showbreak = '↪'
vim.opt.breakindent = true

vim.opt.copyindent = true
vim.opt.breakindent = true

-- Save undo history
vim.opt.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Keep signcolumn on by default
vim.opt.signcolumn = 'yes'
vim.opt.number = true

-- Decrease update time
vim.opt.updatetime = 250

-- Decrease mapped sequence wait time
-- Displays which-key popup sooner
vim.opt.timeoutlen = 300

vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.splitkeep = 'screen' -- for focus.nvim; otherwise screen

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = true
vim.opt.listchars = {
  tab = '» ',
  trail = '·',
  nbsp = '␣',
}

vim.opt.fillchars = {
  eob = ' ',
  lastline = ' ',
  fold = ' ',
}

-- Preview substitutions live, as you type!
vim.opt.inccommand = 'split'

vim.opt.cursorline = true
vim.opt.cursorlineopt = 'number'

vim.opt.scrolloff = 7
vim.opt.sidescrolloff = 3

-- TODO: apparently Postgres files should still be .sql?
vim.filetype.add {
  extension = {
    psql = 'sql',
  },
}

-- I prefer tabs but the formatters for my most-used languages don't :(
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

vim.opt.swapfile = false
vim.opt.autowrite = true
vim.opt.autowriteall = true
vim.opt.autoread = true

vim.opt.cmdheight = 0

vim.opt.wrap = false

vim.opt.termguicolors = true
vim.opt.guicursor:append 't:ver25'

vim.opt.foldmethod = 'expr' -- Define folds using an expression
vim.opt.foldexpr = 'v:lua.vim.treesitter.foldexpr()' -- Use Treesitter for folding
vim.opt.foldlevel = 0
vim.opt.foldlevelstart = 99
vim.opt.foldtext = '' -- Syntax highlight first line of fold

vim.o.laststatus = 0

vim.api.nvim_command 'aunmenu PopUp.How-to\\ disable\\ mouse'
vim.api.nvim_command 'aunmenu PopUp.-1-'
