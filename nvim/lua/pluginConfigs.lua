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

-- NOICE
-- require("noice").setup({
--     lsp = {
--         override = {
--             ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
--             ["vim.lsp.util.stylize_markdown"] = true,
--             ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
--         },
--     },
--     presets = {
--         bottom_search = false, -- use a classic bottom cmdline for search
--         command_palette = true, -- position the cmdline and popupmenu together
--         long_message_to_split = true, -- long messages will be sent to a split
--         inc_rename = false, -- (i dont have inc rename plugin so dont care)
--         lsp_doc_border = true, -- this is nice
--     },
-- })


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


