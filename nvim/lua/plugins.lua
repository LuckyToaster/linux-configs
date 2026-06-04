-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out,                            "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end

vim.opt.rtp:prepend(lazypath)

-- Setup Lazy
require("lazy").setup({
    spec = {
        -- LSP 
        { 'mason-org/mason-lspconfig.nvim', opts = {}, dependencies = { { 'mason-org/mason.nvim', opts = {} }, { 'neovim/nvim-lspconfig', lazy = false } } },
        -- Syntax Highlighting
        { 'nvim-treesitter/nvim-treesitter', build = ':TSUpdate', lazy = false },
        -- Git integration 
        { 'lewis6991/gitsigns.nvim' },
        -- UI
        { 'nvim-lualine/lualine.nvim', dependencies = { 'nvim-tree/nvim-web-devicons' } },
        { 'Mofiqul/vscode.nvim' },
        -- Navigation 
        { 'ibhagwan/fzf-lua', dependencies = { 'nvim-tree/nvim-web-devicons' } },
        { 'nvim-tree/nvim-tree.lua', lazy = false, dependencies = { 'nvim-tree/nvim-web-devicons' } },
        { 'folke/which-key.nvim', event = 'VeryLazy', keys = {{'<leader>?', function() require('which-key').show({ global = false }) end, desc = 'Buffer Local Keymaps (which-key)'} } },
        -- Markdown Support
        { 'MeanderingProgrammer/render-markdown.nvim', dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' } },
    },
    checker = { enabled = true }, -- automatically check for plugin updates
})

-- TreeSitter
local treesitter = require('nvim-treesitter')
treesitter.setup({})
treesitter.install({"python", "c", "c++", "rust", "lua", "bash", "typescript", "javascript", "html", "css", "json", "markdown", "markdown_inline", "vim", "vimdoc", "query"})

-- LSP SERVERS
require("mason-lspconfig").setup {
    ensure_installed = { "basedpyright", "clangd", "rust_analyzer", "bashls", "jsonls", "html", "cssls", "vtsls", "lua_ls" },
}

-- set the type checking for python LSP 
vim.lsp.config('basedpyright', { settings = { basedpyright = { analysis = { typeCheckingMode = "basic" } } } }) -- standard, basic, off

-- LUALINE 
require('lualine').setup({
    options = { theme = 'vscode', globalstatus = true },
    sections = { lualine_c = { 'buffers' } },
})

-- FZF-LUA
require('fzf-lua').setup({ 'border-fused' })

-- GIT SIGNS
require('gitsigns').setup()

-- NVIM-TREE - g? for help menu
require('nvim-tree').setup({ filters = { dotfiles = false }, view = { width = 40 } })

-- Which Key
require('which-key').setup({})
