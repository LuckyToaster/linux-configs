-- LSP SERVERS
local servers = { "pyright", "clangd", "rust_analyzer", "bashls", "jsonls", "html", "cssls", "vtsls", "lua_ls" }
-- Mason: LSP server package manager
require("mason").setup()
require("mason-lspconfig").setup({ ensure_installed = servers })

-- NVIMs built in LSP
for _, server in ipairs(servers) do
    vim.lsp.config(server, {})
    vim.lsp.enable(server)
end

-- TREESITTER: uses LSPs to handle syntax highlighting
local treesitter_languages = { "python", "c", "rust", "lua", "bash", "typescript", "javascript", 'html', 'css', 'json', "markdown", "markdown_inline", "vim", "vimdoc", "query" }
require('nvim-treesitter.configs').setup({
    ensure_installed = treesitter_languages,
    highlight = { enable = true },
})

-- COLORSCHEME
require('vscode').setup({ transparent = false })

-- LUALINE 
require('lualine').setup({
    sections = { lualine_c = { 'buffers' } },
    options = {
        theme = 'vscode',
        disabled_filetypes = { statusline = { 'NvimTree' } }
    },
})

-- FZF-LUA
require('fzf-lua').setup({ 'border-fused'})

-- GIT SIGNS
require('gitsigns').setup()

-- NVIM-TREE (g? in normal mode shows help menu)
require('nvim-tree').setup({
    filters = { dotfiles = false },
    view = { width = 40 }
})


local border = "rounded"
-- 1. Override globally for all LSP floating windows
local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
  opts = opts or {}
  opts.border = opts.border or border
  return orig_util_open_floating_preview(contents, syntax, opts, ...)
end
-- 2. Set for Diagnostics (the <leader>e popup)
vim.diagnostic.config({
  float = { border = border },
})
