-- MASON AND LSPs => https://github.com/williamboman/mason-lspconfig.nvim?tab=readme-ov-file#available-lsp-servers
require("mason").setup()
require("mason-lspconfig").setup({ ensure_installed = { "clangd", "pyright", "rust_analyzer", "lua_ls", "bashls", "jsonls", "html", "cssls", "vtsls", "gopls" } })
local lspconfig = require("lspconfig")
lspconfig.clangd.setup({})
lspconfig.rust_analyzer.setup({})
lspconfig.bashls.setup({})
lspconfig.jsonls.setup({})
lspconfig.html.setup({})
lspconfig.cssls.setup({})
lspconfig.vtsls.setup({})
lspconfig.lua_ls.setup({ settings = { Lua = { diagnostics = { globals = { 'vim' } } } } })
lspconfig.pyright.setup({})
lspconfig.gopls.setup({})

-- TREESITTER
require('nvim-treesitter.configs').setup {
    ensure_installed = "all",
    sync_install = false,
    auto_install = true,
    highlight = { enable = true }
}

-- COLORSCHEME
require('vscode').setup({
    transparent = false,
})


-- LUALINE 
require('lualine').setup({
    sections = { lualine_c = { 'buffers' } },
    options = {
        theme = 'vscode',
        disabled_filetypes = { statusline = { 'NvimTree' } }
    },
})


-- CODE WINDOW
local codewindow = require('codewindow')
codewindow.setup()
codewindow.apply_default_keybinds()

-- FZF-LUA
require('fzf-lua').setup({ 'border-fused' })

-- GIT SIGNS
require('gitsigns').setup()

-- DAP UI (debugger UI)
--require("dapui").setup()

-- NVIM-TREE (g? in normal mode shows help menu)
require('nvim-tree').setup({
    filters = { dotfiles = false },
    view = { width = 40 }
})

