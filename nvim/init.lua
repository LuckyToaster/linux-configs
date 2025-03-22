-- ======================================================================================================
-- = BASIC VIM SETTTINGS ================================================================================
-- ======================================================================================================

local keymap = vim.keymap
local opt = vim.opt

-- disable netrw at the very start of your init.lua (for nvim-tree)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
-- leader
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"         -- Make sure to setup `mapleader` and `maplocalleader` before loading lazy.nvim
-- tabs
opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.smarttab = true
-- line numbers
opt.number = true
opt.relativenumber = true
opt.cursorline = true               -- highlight current cursor line
-- search settings
opt.ignorecase = true               -- case insensitive search
opt.smartcase = true                -- assumes case sensitive if mixed case in search
-- clipboard, mouse support
opt.clipboard = 'unnamedplus'       -- Set up the clipboard YOU NEED TO HAVE XCLIP INSTALLED
opt.mouse = 'a'                     -- Enable mouse support
-- other
opt.laststatus = 2                  -- always show the status line
opt.wrap = false                    -- same as nowrap
opt.showmatch = true                -- highlight matching parenthesis
opt.signcolumn = "yes"              -- show sign column so that text doesn't shift
opt.backspace = "indent,eol,start"  -- allow backspace on any of these
opt.scrolloff = 15                  -- when scrolling, prevent cursor from being at first or last line
opt.sidescrolloff = 30
opt.splitright = true

-- ======================================================================================================
-- = PLUGIN MANAGER =====================================================================================
-- ======================================================================================================

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
        {'Mofiqul/vscode.nvim'},
        {"ibhagwan/fzf-lua", dependencies = { "nvim-tree/nvim-web-devicons" }}, --, opts = {}},
        {'nvim-lualine/lualine.nvim', dependencies = {'nvim-tree/nvim-web-devicons'}},
        {'rmagatti/auto-session', lazy = false, opts = {suppressed_dirs = {'~/Downloads', '/'}}},
        {'nvim-tree/nvim-tree.lua', lazy = false, dependencies = { 'nvim-tree/nvim-web-devicons'}},
        {'gorbit99/codewindow.nvim'}, -- leader mm (minimap toggle) leader mf (minimap focus)
    },
    install = { colorscheme = { "vscode" } },    -- colorscheme that will be used when installing plugins.
    checker = { enabled = true },                -- automatically check for plugin updates
})

-- ======================================================================================================
-- = KEYMAPS ============================================================================================
-- ======================================================================================================

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
keymap.set('n', '<leader>s', ':vs | enew<CR>', { desc = "Open new buffer in a vertical split" })
keymap.set('n', '<C-h>', '<C-w>h', { desc = "navigate splits with 'control + hjkl'" })
keymap.set('n', '<C-j>', '<C-w>j', { desc = "navigate splits with 'control + hjkl'" })
keymap.set('n', '<C-k>', '<C-w>k', { desc = "navigate splits with 'control + hjkl'" })
keymap.set('n', '<C-l>', '<C-w>l', { desc = "navigate splits with 'control + hjkl'" })
keymap.set('n', '<C-left>', ':vertical resize +4<CR>', { desc = "resize splits with 'control + arrow keys'" })
keymap.set('n', '<C-right>', ':vertical resize -4<CR>', { desc = "resize splits with 'control + arrow keys'" })
keymap.set('n', '<C-up>', ':horizontal resize +4<CR>', { desc = "resize splits with 'control + arrow keys'" })
keymap.set('n', '<C-down>', ':horizontal resize -4<CR>', { desc = "resize splits with 'control + arrow keys'" })
-- LSP 
vim.api.nvim_create_autocmd('LspAttach', {
    desc = 'LSP actions',
    callback = function(event)
        local opts = {buffer = event.buf}
        vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
        vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
        vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
        vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
        vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
        vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
        vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
        vim.keymap.set('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
        vim.keymap.set({'n', 'x'}, '<F3>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)
        vim.keymap.set('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
    end,
})
-- nvim-tree
require('nvim-tree').setup()
keymap.set('n', '<leader>ft', ':NvimTreeToggle<CR>', {noremap = true, silent = true})

-- fuzzy finder
require('fzf-lua').setup({ defaults = 'border-fused' })
keymap.set('n', '<leader>ff', ':FzfLua files', { desc = "fuzzy find files" })
keymap.set('n', '<leader>fg', ':FzfLua files cwd=/home/lucky', { desc = "fuzzy find files from home directory" })
keymap.set('n', '<leader>fb', ':FzfLua buffers', { desc = "fuzzy find open buffers" })
keymap.set('n', '<leader>gg', ':FzfLua grep', { desc = "fuzzy find using grep" })

-- Auto-session
keymap.set('n', '<leader>sr', ":SessionRes ore<CR>", { desc = "Restore session of cwd if any" })
keymap.set('n', '<leader>sw', ":SessionSave<CR>", { desc = "Save current session" })
keymap.set('n', '<leader>ss', ":SessionSearch<CR>", { desc = "Search for open sessions (uses telescope by default)" })
opt.sessionoptions:append('localoptions')

-- disable terminal numbers in terminal mode
vim.api.nvim_create_autocmd("TermOpen", {
    pattern = "*",
    callback = function()
        vim.opt_local.number = false            -- Disable absolute line numbers
        vim.opt_local.relativenumber = false    -- Disable relative line numbers
    end,
})

-- ======================================================================================================
-- = PLUGIN CONFIGURATION ===============================================================================
-- ======================================================================================================

-- COLORSCHEME => https://github.com/nvim-treesitter/nvim-treesitter/wiki/Colorschemes
vim.o.background =  'dark'
vim.cmd.syntax "off"
vim.cmd.colorscheme "vscode"

-- LUALINE COLORSCHEME
require('lualine').setup({options = {theme = 'vscode'}})

-- CODE WINDOW
local codewindow = require('codewindow')
codewindow.setup()
codewindow.apply_default_keybinds()

-- TREESITTER
require('nvim-treesitter.configs').setup {
    ensure_installed = { "c", "cpp", "python", "javascript", "scala", "rust", "bash", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline", "json" }, -- A list of parser names, or "all" (the listed parsers MUST always be installed)
    sync_install = false,
    auto_install = true,
    highlight = { enable = true }
}

-- MASON => https://github.com/williamboman/mason-lspconfig.nvim?tab=readme-ov-file#available-lsp-servers
require("mason").setup()
require("mason-lspconfig").setup({ ensure_installed = { "clangd", "pyright", "rust_analyzer", "lua_ls", "bashls", "jsonls", "html", "cssls", "vtsls" } })

-- LSP CONFIGURATION
local lspconfig = require("lspconfig")
lspconfig.clangd.setup({})
lspconfig.rust_analyzer.setup({})
lspconfig.lua_ls.setup({settings = {Lua = {diagnostics = {globals = {'vim'}}}}})
lspconfig.bashls.setup({})
lspconfig.jsonls.setup({})
lspconfig.html.setup({})
lspconfig.cssls.setup({})
lspconfig.vtsls.setup({})
lspconfig.pyright.setup({
    settings = {
        python = {
            pythonPath = '/hom/lucky/Documents/classes/info/info_env/bin/python' --pythonPath = vim.fn.exepath('python') --pythonPath = '/home/lucky/Documents/classes/ai/ai_env/bin/python' --pythonPath = '/home/lucky/Documents/classes/ai/ai_env/bin/python3', 
        },
        analysis = { --extraPaths = { '/home/lucky/Documents/classes/ai/ai_env/lib/python3.11/site-packages' },  -- Add site-packages directory
            autoSearchPaths = true,
            diagnosticMode = "openFilesOnly",
            useLibraryCodeForTypes = true
        }
    }
})

