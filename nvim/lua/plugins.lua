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
        -- { 'xiyaowong/transparent.nvim' },
        -- colorschemes
        { 'Mofiqul/vscode.nvim' },
        { 'folke/tokyonight.nvim' },
        { 'morhetz/gruvbox' },
        { 'catppuccin/nvim' },
        { 'mofiqul/dracula.nvim' },
        -- Navigation 
        { 'nvim-tree/nvim-tree.lua', lazy = false, dependencies = { 'nvim-tree/nvim-web-devicons' } },
        { 'ibhagwan/fzf-lua', dependencies = { 'nvim-tree/nvim-web-devicons' } },
        { 'folke/which-key.nvim', event = 'VeryLazy', keys = {{'<leader>?', function() require('which-key').show({ global = false }) end, desc = 'Buffer Local Keymaps (which-key)'} } },
        -- Markdown Support
        { 'MeanderingProgrammer/render-markdown.nvim', dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' } },
    },
    checker = { enabled = true }, -- automatically check for plugin updates
})

-- require('transparent').setup()
-- require('transparent').clear_prefix('lualine')
 -- Optional, you don't have to run setup.
-- require("transparent").setup({
--   -- table: default groups
--   groups = {
--     'Normal', 'NormalNC', 'Comment', 'Constant', 'Special', 'Identifier',
--     'Statement', 'PreProc', 'Type', 'Underlined', 'Todo', 'String', 'Function',
--     'Conditional', 'Repeat', 'Operator', 'Structure', 'LineNr', 'NonText',
--     'SignColumn', 'CursorLine', 'CursorLineNr', 'StatusLine', 'StatusLineNC',
--     'EndOfBuffer',
--   },
--   -- table: additional groups that should be cleared
--   extra_groups = {},
--   -- table: groups you don't want to clear
--   exclude_groups = {},
--   -- function: code to be executed after highlight groups are cleared
--   -- Also the user event "TransparentClear" will be triggered
--   on_clear = function() end,
-- })
--
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
    options = { theme = 'auto', globalstatus = true },
    sections = { 
        lualine_c = { 'buffers' },
        lualine_b = { 'diagnostics' }
    },
})

-- FZF-LUA
require('fzf-lua').setup({
    'border-fused',
    hls = { normal = 'Normal', border = 'FloatBorder' },
    fzf_colors = true -- enable dynamic color generation
})


-- GIT SIGNS
require('gitsigns').setup()

-- NVIM-TREE - g? for help menu
require('nvim-tree').setup({ filters = { dotfiles = false }, view = { width = 40 } })

-- Which Key
require('which-key').setup({})
