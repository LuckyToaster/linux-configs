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
            { out,                            "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end

vim.opt.rtp:prepend(lazypath)

-- Setup lazy.nvim
require("lazy").setup({
    spec = {
        -- lsp, syntax highlighting ...
        { 'williamboman/mason.nvim' },
        { 'williamboman/mason-lspconfig.nvim' },
        { 'neovim/nvim-lspconfig', lazy = false },
        { 'nvim-treesitter/nvim-treesitter' },
        -- important 
        { "ibhagwan/fzf-lua", dependencies = { "nvim-tree/nvim-web-devicons" } },
        { 'nvim-tree/nvim-tree.lua', lazy = false, dependencies = { 'nvim-tree/nvim-web-devicons' } },
        { 'nvim-lualine/lualine.nvim', dependencies = { 'nvim-tree/nvim-web-devicons' } },
        { "folke/noice.nvim", event = "VeryLazy", dependencies = { "MunifTanjim/nui.nvim", "rcarriga/nvim-notify" } },
        -- other nice stuff
        { 'lewis6991/gitsigns.nvim' }, -- git stuff
        { 'Mofiqul/vscode.nvim' }, -- colorscheme
        { 'gorbit99/codewindow.nvim' }, -- leader mm (minimap toggle) leader mf (minimap focus)
        { 'MeanderingProgrammer/render-markdown.nvim', dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' } },
    },
    install = { colorscheme = { "vscode" } }, -- colorscheme that will be used when installing plugins.
    checker = { enabled = true },             -- automatically check for plugin updates
})
