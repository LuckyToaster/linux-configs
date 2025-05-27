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
        -- Git integration 
        { 'lewis6991/gitsigns.nvim' }, -- git stuff
        -- Navigation and UI
        { "ibhagwan/fzf-lua", dependencies = { "nvim-tree/nvim-web-devicons" } },
        { 'nvim-tree/nvim-tree.lua', lazy = false, dependencies = { 'nvim-tree/nvim-web-devicons' } },
        { 'nvim-lualine/lualine.nvim', dependencies = { 'nvim-tree/nvim-web-devicons' } },
        { 'gorbit99/codewindow.nvim' }, -- leader mm (minimap toggle) leader mf (minimap focus)
        { 'Mofiqul/vscode.nvim' }, -- colorscheme
        { "sphamba/smear-cursor.nvim", opts = {} },
        { "folke/which-key.nvim", event = "VeryLazy", keys = {{"<leader>?", function() require("which-key").show({ global = false }) end, desc = "Buffer Local Keymaps (which-key)"}}},
        -- Render markdown inside nvim
        { 'MeanderingProgrammer/render-markdown.nvim', dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' } },
        { 'rcarriga/nvim-notify' },
        { 'github/copilot.vim' }
        -- Debugger for nvim (don't know how to setup)
        --{ "rcarriga/nvim-dap-ui", dependencies = {"mfussenegger/nvim-dap", "nvim-neotest/nvim-nio"} }
    },
    install = { colorscheme = { "vscode" } }, -- colorscheme that will be used when installing plugins.
    checker = { enabled = true },             -- automatically check for plugin updates
})
