require('fzf-lua').setup({ 'border-fused' }) -- FZF-LUA
require('gitsigns').setup() -- GIT SIGNS
require('nvim-tree').setup({ filters = { dotfiles = false }, view = { width = 45 } }) -- NVIM-TREE (g? in normal mode shows help menu)

-- CODE WINDOW
local codewindow = require('codewindow')
codewindow.setup()
codewindow.apply_default_keybinds()

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
        override = {
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            ["vim.lsp.util.stylize_markdown"] = true,
            ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
        },
    },

    presets = {
        bottom_search = false, -- use a classic bottom cmdline for search
        command_palette = true, -- position the cmdline and popupmenu together
        long_message_to_split = true, -- long messages will be sent to a split
        inc_rename = false, -- (i dont have inc rename plugin so dont care)
        lsp_doc_border = true, -- this is nice
    },
})
