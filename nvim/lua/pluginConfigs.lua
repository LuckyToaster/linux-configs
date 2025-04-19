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
    ensure_installed = "all", --ensure_installed = { "c", "cpp", "python", "javascript", "scala", "rust", "bash", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline", "json" }, 
    sync_install = false,
    auto_install = true,
    highlight = { enable = true }
}

-- COLORSCHEME => https://github.com/nvim-treesitter/nvim-treesitter/wiki/Colorschemes
vim.o.background = 'dark'
vim.cmd.syntax "off"
vim.cmd.colorscheme "vscode"

-- LUALINE 
require('lualine').setup({
    options = {
        theme = 'vscode',
        disabled_filetypes = { statusline = { 'NvimTree' } }
    },
    sections = {
        lualine_a = {'mode'},
        lualine_b = {'branch', 'diff', 'diagnostics'},
        lualine_c = { 'buffers' }, --lualine_c = {'filename'},
        lualine_x = {'encoding', 'fileformat', 'filetype'},
        lualine_y = {'progress'},
        lualine_z = {'location'}
  },
})

-- NOICE
require("noice").setup({
    lsp = {
        override = { -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            ["vim.lsp.util.stylize_markdown"] = true,
            ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
        },
    },
    presets = { -- you can enable a preset for easier configuration
        long_message_to_split = true, -- long messages will be sent to a split
        lsp_doc_border = true, -- add a border to hover docs and signature help
    },
    cmdline = {
        view = 'cmdline', --'cmdline_popup', 'cmdline'
    },
})

-- NVIM-TREE (g? in normal mode shows help menu)
require('nvim-tree').setup({
    filters = { dotfiles = false },
    view = { width = 45 },
})

-- CODE WINDOW
local codewindow = require('codewindow')
codewindow.setup()
codewindow.apply_default_keybinds()

-- FZF-LUA
require('fzf-lua').setup({ 'border-fused' })

-- GIT SIGNS
require('gitsigns').setup()
