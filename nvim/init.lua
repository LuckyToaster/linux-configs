local keymap = vim.keymap
local opt = vim.opt

-- disable netrw at the very start of your init.lua (for nvim-tree)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"         -- Make sure to setup `mapleader` and `maplocalleader` before loading lazy.nvim
opt.splitbelow = true
opt.splitright = true
opt.termguicolors = true
opt.number = true
opt.relativenumber = true
opt.cursorline = true               -- highlight current cursor line
opt.signcolumn = "yes"              -- show sign column so that text doesn't shift
opt.backspace = "indent,eol,start"  -- allow backspace on any of these
opt.showmatch = true                -- highlight matching parenthesis
opt.clipboard = 'unnamedplus'       -- Set up the clipboard YOU NEED TO HAVE XCLIP INSTALLED
opt.mouse = 'a'                     -- Enable mouse support
opt.laststatus = 2                  -- always show the status line
opt.showtabline = 1                 -- don't always show the tab line
opt.ruler = true                    -- show the cursor position all the time
opt.wrap = false                    -- same as nowrap
opt.formatoptions:remove('r')       -- stop inserting comment leader when new line on insert mode
opt.formatoptions:remove('o')       -- stop auto wrapping comments when inserting text
opt.scrolloff = 15                   -- when scrolling, prevent cursor from being at first or last line
opt.sidescrolloff = 30
opt.ignorecase = true               -- case insensitive search
opt.smartcase = true                -- assumes case sensitive if mixed case in search
opt.tabstop = 4
opt.shiftwidth = 4
--opt.autoindent = true
--opt.smartindent = true
opt.expandtab = true
opt.smarttab = true
--opt.scrollbarState = 'hidden'       -- try to prevent borders / take up all screen space

keymap.set("i", "df", "<ESC>", { desc = "Exit insert mode with 'df'"})
keymap.set('t', 'df', '<C-\\><C-n>', { desc = "Exit insert mode when in terminal mode" })
keymap.set("n", "<leader>nh", ":nohl<CR>", {desc = "no highlight, clear search highlights"})

-- BUFFERS 
keymap.set('n', '<leader>n', ':enew<CR>', { desc = "open a new empty buffer" })
keymap.set('n', '<leader>w', ':bd!<CR>', { desc = "Close / delete current buffer" })
keymap.set('n', '<leader>t', ':term<CR>', { desc = "Open a terminal buffer" })
keymap.set('n', '<leader>l', ':bnext<CR>', { desc = "Switch to next open buffer" })
keymap.set('n', '<leader>h', ':bprev<CR>', { desc = "Switch to previous open buffer" })

-- SPLITS
keymap.set('n', '<leader>sh', ':sp | enew<CR>', { desc = "Open new buffer in a horizontal split" })
keymap.set('n', '<leader>sv', ':vs | enew<CR>', { desc = "Open new buffer in a vertical split" })

keymap.set('n', '<leader>sth', ':sp | :term<CR>', { desc = "Open terminal buffer in a horizontal split" })
keymap.set('n', '<leader>stv', ':vs | :term<CR>', { desc = "Open terminal bufferin a  vertical split" })

keymap.set('n', '<leader>ssv', '<C-w>t<C-w>H', { desc = "change 2 splits from horizontal to vertical" }) -- too complicated and unnecessary?
keymap.set('n', '<leader>ssh', '<C-w>t<C-w>K', { desc = "change 2 splits from vertical to horizontal" }) -- too complicated and unnecessary?

keymap.set('n', '<C-h>', '<C-w>h', { desc = "navigate splits with 'control + hjkl'" })
keymap.set('n', '<C-j>', '<C-w>j', { desc = "navigate splits with 'control + hjkl'" })
keymap.set('n', '<C-k>', '<C-w>k', { desc = "navigate splits with 'control + hjkl'" })
keymap.set('n', '<C-l>', '<C-w>l', { desc = "navigate splits with 'control + hjkl'" })

keymap.set('n', '<C-left>', ':vertical resize +4<CR>', { desc = "resize splits with 'control + arrow keys'" })
keymap.set('n', '<C-right>', ':vertical resize -4<CR>', { desc = "resize splits with 'control + arrow keys'" })
keymap.set('n', '<C-up>', ':horizontal resize +4<CR>', { desc = "resize splits with 'control + arrow keys'" })
keymap.set('n', '<C-down>', ':horizontal resize -4<CR>', { desc = "resize splits with 'control + arrow keys'" })

vim.api.nvim_create_autocmd("TermOpen", {       -- Disable line numbers in terminal mode
    pattern = "*",
    callback = function()
        vim.opt_local.number = false            -- Disable absolute line numbers
        vim.opt_local.relativenumber = false    -- Disable relative line numbers
    end,
})


-- ==================
-- = PLUGIN MANAGER =
-- ==================

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out, "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
    os.exit(1)
    end
end
opt.rtp:prepend(lazypath)

-- Setup lazy.nvim
require("lazy").setup({
    spec = {
        {'williamboman/mason.nvim'},
        {'williamboman/mason-lspconfig.nvim'},
        {'neovim/nvim-lspconfig', lazy = false},
        {'nvim-treesitter/nvim-treesitter'},
        {'christianchiarulli/nvcode-color-schemes.vim'}, -- colorschemes that work well with tree-sitter (and depend on it as a dependency)
        {'nvim-telescope/telescope.nvim', tag = '0.1.8', dependencies = { 'nvim-lua/plenary.nvim' }},
        {'rmagatti/auto-session', lazy = false, opts = {suppressed_dirs = {'~/Downloads', '/'}}},
        {'nvim-tree/nvim-tree.lua', lazy = false, dependencies = { 'nvim-tree/nvim-web-devicons'}},
        {'nvim-lualine/lualine.nvim', dependencies = {'nvim-tree/nvim-web-devicons'}},
    },
    -- Configure any other settings here. See the documentation for more details.
    install = { colorscheme = { "nvcode" } },    -- colorscheme that will be used when installing plugins.
    checker = { enabled = true },                -- automatically check for plugin updates
})


-- ===================
-- = PLUGIN SETTINGS =
-- ==================

-- COLORSCHEME => https://github.com/nvim-treesitter/nvim-treesitter/wiki/Colorschemes
vim.cmd("colorscheme nvcode") -- vim.cmd("syntax on") will fuck up the treesitter syntax highlighting

-- Lualine 
require('lualine').setup({options = {theme = 'vscode',},})

-- nvim-tree
require('nvim-tree').setup()
keymap.set('n', '<leader>ft', ':NvimTreeToggle<CR>', {noremap = true, silent = true})

-- fuzzy finder
local telescope = require('telescope.builtin')
keymap.set('n', '<leader>fb', telescope.buffers, { desc = "fuzzy find buffers" })
keymap.set('n', '<leader>fh', telescope.help_tags, { desc = "shows help info for a bunch of shit you have installed" })
keymap.set('n', '<leader>ff', function() telescope.find_files({hidden = true}) end, {desc = "fuzzy find files"})
keymap.set('n', '<leader>fg', function() telescope.find_files({search_dirs= {"/home/lucky"}, hidden = true}) end, {desc = "fuzzy find from home"})

-- Auto-session
keymap.set('n', '<leader>sr', ":SessionRes ore<CR>", { desc = "Restore session of cwd if any" })
keymap.set('n', '<leader>sw', ":SessionSave<CR>", { desc = "Save current session" })
keymap.set('n', '<leader>ss', ":SessionSearch<CR>", { desc = "Search for open sessions (uses telescope by default)" })
opt.sessionoptions:append('localoptions')

-- Mason setup (auto-install LSP servers)
require("mason").setup()
require("mason-lspconfig").setup({
    ensure_installed = {
        "clangd", "pyright", "rust_analyzer", "lua_ls", "bashls", "jsonls", "yamlls", "ts_ls", "html", "cssls", "glsl_analyzer"
    }
})

-- LSP CONFIGURATION
local lspconfig = require("lspconfig")
lspconfig.clangd.setup({})
lspconfig.rust_analyzer.setup({})
lspconfig.lua_ls.setup({settings = {Lua = {diagnostics = {globals = {'vim'}}}}})
lspconfig.bashls.setup({})
lspconfig.jsonls.setup({})
lspconfig.yamlls.setup({})
lspconfig.ts_ls.setup({})
lspconfig.vtsls.setup({})
lspconfig.html.setup({})
lspconfig.cssls.setup({})
lspconfig.pyright.setup({
    settings = {
        python = {
            --pythonPath = vim.fn.exepath('python')
            --pythonPath = '/home/lucky/Documents/classes/ai/ai_env/bin/python'
            pythonPath = '/home/lucky/Documents/classes/ai/ai_env/bin/python3',  -- Set path to your virtual environment Python
        },
        analysis = {
            extraPaths = { '/home/lucky/Documents/classes/ai/ai_env/lib/python3.11/site-packages' },  -- Add site-packages directory
            autoSearchPaths = true,
            diagnosticMode = "openFilesOnly",
            useLibraryCodeForTypes = true
        }
    }
})


-- TreeSitter (syntax highlighting and indentation)
require('nvim-treesitter.configs').setup {
    ensure_installed = { "c", "cpp", "python", "javascript", "scala", "rust", "bash", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline", "json" }, -- A list of parser names, or "all" (the listed parsers MUST always be installed)
    sync_install = false, -- Install parsers synchronously (only applied to `ensure_installed`)
    auto_install = true,
    highlight = {
        enable = true,
    }
}


--vim.keymap.set('n', '<leader>d', vim.lsp.code_action, {})
--vim.keymap.set('n', '<leader>c', vim.lsp.hover, {})

