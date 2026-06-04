-- disable netrw at the very start of your init.lua (for nvim-tree)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
-- leader
vim.g.mapleader = " "
vim.g.maplocalleader = "\\" -- Make sure to setup `mapleader` and `maplocalleader` before loading lazy.nvim
-- tabs
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smarttab = true
-- line numbers
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true              -- highlight current cursor line
-- search settings
vim.opt.ignorecase = true              -- case insensitive search
vim.opt.smartcase = true               -- assumes case sensitive if mixed case in search
-- clipboard, mouse support
vim.opt.clipboard = 'unnamedplus'      -- Set up the clipboard YOU NEED TO HAVE XCLIP INSTALLED
vim.opt.mouse = 'a'                    -- Enable mouse support
-- other
vim.opt.laststatus = 2                 -- always show the status line
vim.opt.wrap = false                   -- same as nowrap
vim.opt.showmatch = true               -- highlight matching parenthesis
vim.opt.signcolumn = "yes"             -- show sign column so that text doesn't shift
vim.opt.backspace = "indent,eol,start" -- allow backspace on any of these
vim.opt.scrolloff = 15                 -- when scrolling, prevent cursor from being at first or last line
vim.opt.sidescrolloff = 30
vim.opt.splitright = true
vim.opt.timeoutlen = 300               -- maximum delay to register a keymap
vim.opt.termguicolors = true
-- vim.opt.autochdir = true               -- important for FZF **TAB functionality
vim.cmd [[autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o]] -- stop auto commenting

vim.o.winborder = 'rounded' -- makes all hover / floating windows have rounded borders

-- require('pluginManager')
-- require('pluginConfigs')
require('plugins')
require('keymaps')
require('misc').autocmds()

vim.o.background = 'dark'
vim.cmd.colorscheme "vscode"
-- vim.cmd.colorscheme "catppuccin-nvim"

