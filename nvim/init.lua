-- disable netrw at the very start of your init.lua (for nvim-tree)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
-- leader
vim.g.mapleader = " "
vim.g.maplocalleader = "\\" -- Make sure to setup `mapleader` and `maplocalleader` before loading lazy.nvim
-- tabs
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smarttab = true
-- line numbers
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true              -- highlight current cursor line
-- search settings
vim.opt.ignorecase = true              -- case insensitive search
vim.opt.smartcase = true               -- assumes case sensitive if mixed case in search
-- clipboard, mouse support
vim.opt.clipboard = 'unnamedplus'      -- Set up the clipboard YOU NEED TO HAVE XCLIP INSTALLED
vim.opt.mouse = 'a'                    -- Enable mouse support
-- other
vim.opt.laststatus = 2                 -- always show the status line
vim.opt.wrap = false                   -- same as nowrap
vim.opt.showmatch = true               -- highlight matching parenthesis
vim.opt.signcolumn = "yes"             -- show sign column so that text doesn't shift
vim.opt.backspace = "indent,eol,start" -- allow backspace on any of these
vim.opt.scrolloff = 15                 -- when scrolling, prevent cursor from being at first or last line
vim.opt.sidescrolloff = 30
vim.opt.splitright = true

require('pluginManager')
require('pluginConfigs')
require('keymaps')

-- COLORSCHEME => https://github.com/nvim-treesitter/nvim-treesitter/wiki/Colorschemes
vim.o.background = 'dark'
vim.cmd.syntax "off"
vim.cmd.colorscheme "vscode"

-- ======================================================================================================
-- = PLUGIN MANAGER =====================================================================================
-- ======================================================================================================

-- Bootstrap lazy.nvim
-- local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
-- if not (vim.uv or vim.loop).fs_stat(lazypath) then
--     local lazyrepo = "https://github.com/folke/lazy.nvim.git"
--     local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
--     if vim.v.shell_error ~= 0 then
--         vim.api.nvim_echo({
--             { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
--             { out,                            "WarningMsg" },
--             { "\nPress any key to exit..." },
--         }, true, {})
--         vim.fn.getchar()
--         os.exit(1)
--     end
-- end
-- opt.rtp:prepend(lazypath)
--
-- -- Setup lazy.nvim
-- require("lazy").setup({
--     spec = {
--         -- lsp, syntax highlighting ...
--         { 'williamboman/mason.nvim' },
--         { 'williamboman/mason-lspconfig.nvim' },
--         { 'neovim/nvim-lspconfig', lazy = false },
--         { 'nvim-treesitter/nvim-treesitter' },
--         -- important 
--         { "ibhagwan/fzf-lua", dependencies = { "nvim-tree/nvim-web-devicons" } },
--         { 'nvim-tree/nvim-tree.lua', lazy = false, dependencies = { 'nvim-tree/nvim-web-devicons' } },
--         { 'nvim-lualine/lualine.nvim', dependencies = { 'nvim-tree/nvim-web-devicons' } },
--         { "folke/noice.nvim", event = "VeryLazy", dependencies = { "MunifTanjim/nui.nvim", "rcarriga/nvim-notify" } },
--         -- other nice stuff
--         { 'lewis6991/gitsigns.nvim' }, -- git stuff
--         { 'Mofiqul/vscode.nvim' }, -- colorscheme
--         { 'gorbit99/codewindow.nvim' }, -- leader mm (minimap toggle) leader mf (minimap focus)
--         { 'MeanderingProgrammer/render-markdown.nvim', dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' } },
--     },
--     install = { colorscheme = { "vscode" } }, -- colorscheme that will be used when installing plugins.
--     checker = { enabled = true },             -- automatically check for plugin updates
-- })


-- ======================================================================================================
-- = PLUGIN CONFIGURATION ===============================================================================
-- ======================================================================================================

-- MASON AND LSPs => https://github.com/williamboman/mason-lspconfig.nvim?tab=readme-ov-file#available-lsp-servers
-- require("mason").setup()
-- require("mason-lspconfig").setup({ ensure_installed = { "clangd", "pyright", "rust_analyzer", "lua_ls", "bashls", "jsonls", "html", "cssls", "vtsls", "gopls" } })
-- local lspconfig = require("lspconfig")
-- lspconfig.clangd.setup({})
-- lspconfig.rust_analyzer.setup({})
-- lspconfig.bashls.setup({})
-- lspconfig.jsonls.setup({})
-- lspconfig.html.setup({})
-- lspconfig.cssls.setup({})
-- lspconfig.vtsls.setup({})
-- lspconfig.lua_ls.setup({ settings = { Lua = { diagnostics = { globals = { 'vim' } } } } })
-- lspconfig.pyright.setup({})
-- lspconfig.gopls.setup({})
--
-- -- TREESITTER
-- require('nvim-treesitter.configs').setup {
--     ensure_installed = "all", --ensure_installed = { "c", "cpp", "python", "javascript", "scala", "rust", "bash", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline", "json" }, 
--     sync_install = false,
--     auto_install = true,
--     highlight = { enable = true }
-- }
--
-- -- COLORSCHEME => https://github.com/nvim-treesitter/nvim-treesitter/wiki/Colorschemes
-- vim.o.background = 'dark'
-- vim.cmd.syntax "off"
-- vim.cmd.colorscheme "vscode"
--
-- -- LUALINE 
-- require('lualine').setup({
--     options = {
--         theme = 'vscode',
--         disabled_filetypes = { statusline = { 'NvimTree' } }
--     },
--     sections = {
--         lualine_a = {'mode'},
--         lualine_b = {'branch', 'diff', 'diagnostics'},
--         lualine_c = { 'buffers' }, --lualine_c = {'filename'},
--         lualine_x = {'encoding', 'fileformat', 'filetype'},
--         lualine_y = {'progress'},
--         lualine_z = {'location'}
--   },
-- })
--
-- -- NOICE
-- require("noice").setup({
--     lsp = {
--         override = { -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
--             ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
--             ["vim.lsp.util.stylize_markdown"] = true,
--             ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
--         },
--     },
--     presets = { -- you can enable a preset for easier configuration
--         long_message_to_split = true, -- long messages will be sent to a split
--         lsp_doc_border = true, -- add a border to hover docs and signature help
--     },
--     cmdline = {
--         view = 'cmdline', --'cmdline_popup', 'cmdline'
--     },
-- })
--
-- -- NVIM-TREE (g? in normal mode shows help menu)
-- require('nvim-tree').setup({
--     filters = { dotfiles = false },
--     view = { width = 45 },
-- })
--
-- -- CODE WINDOW
-- local codewindow = require('codewindow')
-- codewindow.setup()
-- codewindow.apply_default_keybinds()
--
-- -- FZF-LUA
-- require('fzf-lua').setup({ 'border-fused' })
--
-- -- GIT SIGNS
-- require('gitsigns').setup()


-- ======================================================================================================
-- = KEYMAPS ============================================================================================
-- ======================================================================================================

-- keymap.set("i", "df", "<ESC>", { desc = "Exit insert mode with 'df'" })
-- keymap.set('t', 'df', '<C-\\><C-n>', { desc = "Exit insert mode when in terminal mode" })
-- keymap.set("n", "<leader>nh", "<cmd>nohl<CR>", { desc = "no highlight, clear search highlights" })
-- -- BUFFERS
-- keymap.set('n', '<leader>n', '<cmd>enew<cr>', { desc = "open a new empty buffer" })
-- keymap.set('n', '<leader>w', '<cmd>bd!<cr>', { desc = "Close / delete current buffer" })
-- keymap.set('n', '<leader>t', '<cmd>term<cr>', { desc = "Open a terminal buffer" })
-- keymap.set('n', '<leader>l', '<cmd>bnext<cr>', { desc = "Switch to next open buffer" })
-- keymap.set('n', '<leader>h', '<cmd>bprev<cr>', { desc = "Switch to previous open buffer" })
-- -- SPLITS
-- keymap.set('n', '<leader>s', '<cmd>vs | enew<cr>', { desc = "Open new buffer in a vertical split" })
-- keymap.set('n', '<C-h>', '<C-w>h', { desc = "navigate splits with 'control + hjkl'" })
-- keymap.set('n', '<C-j>', '<C-w>j', { desc = "navigate splits with 'control + hjkl'" })
-- keymap.set('n', '<C-k>', '<C-w>k', { desc = "navigate splits with 'control + hjkl'" })
-- keymap.set('n', '<C-l>', '<C-w>l', { desc = "navigate splits with 'control + hjkl'" })
-- keymap.set('n', '<C-left>', '<cmd>vertical resize +4<CR>', { desc = "resize splits with 'control + arrow keys'" })
-- keymap.set('n', '<C-right>', '<cmd>vertical resize -4<CR>', { desc = "resize splits with 'control + arrow keys'" })
-- keymap.set('n', '<C-up>', '<cmd>horizontal resize +4<CR>', { desc = "resize splits with 'control + arrow keys'" })
-- keymap.set('n', '<C-down>', '<cmd>horizontal resize -4<CR>', { desc = "resize splits with 'control + arrow keys'" })
-- -- LSP
-- vim.api.nvim_create_autocmd('LspAttach', {
--     desc = 'LSP actions',
--     callback = function(event)
--         local opts = { buffer = event.buf }
--         vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
--         vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
--         vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
--         vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
--         vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
--         vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
--         vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
--         vim.keymap.set('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
--         vim.keymap.set({ 'n', 'x' }, '<F3>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)
--         vim.keymap.set('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
--     end,
-- })
-- -- nvim-tree
-- keymap.set('n', '<leader>ft', '<cmd>NvimTreeToggle<cr>', { noremap = true, silent = true })
-- keymap.set('n', '?', '<cmd>NvimTreeToggleHelp<cr>', { noremap = true, silent = true })
--
-- -- FZF-LUA
-- require('fzf-lua').setup({ 'border-fused' })
-- keymap.set('n', '<leader>ff', '<Cmd>FzfLua files<cr>', { desc = "fuzzy find files from CWD" })
-- keymap.set('n', '<leader>fh', '<Cmd>FzfLua files cwd=/home/lucky/<CR>', { desc = "fuzzy find files from ~" })
-- keymap.set('n', '<leader>fb', '<Cmd>FzfLua buffers<cr>', { desc = "fuzzy find open buffers" })
-- keymap.set('n', '<leader>fg', '<Cmd>FzfLua grep<cr>', { desc = "fuzzy find using grep" })
--
-- -- GITSIGNS 
-- keymap.set('n', '<leader>gb', '<cmd>Gitsigns toggle_current_line_blame<CR>', { desc = "view changed lines" })
-- keymap.set('n', '<leader>gv', '<Cmd>Gitsigns preview_hunk_inline<CR>', { desc = "view changed lines" })
-- keymap.set('n', '<leader>gk', '<Cmd>Gitsigns prev_hunk<CR><Cmd>Gitsigns preview_hunk_inline<CR>', { desc = "view changed lines" })
-- keymap.set('n', '<leader>gj', '<Cmd>Gitsigns next_hunk<CR><Cmd>Gitsigns preview_hunk_inline<CR>', { desc = "view changed lines" })
--
-- -- disable terminal numbers in terminal mode
-- vim.api.nvim_create_autocmd("TermOpen", {
--     pattern = "*",
--     callback = function()
--         vim.opt_local.number = false         -- Disable absolute line numbers
--         vim.opt_local.relativenumber = false -- Disable relative line numbers
--     end,
-- })
--
-- local gitCommit = function()
--     vim.ui.input({ prompt = 'Commit Message: ' }, function(msg) if msg then vim.cmd('!git commit -m "' .. msg .. '"') end end)
-- end
--
--
-- local gitPush = function()
--     local handle = io.popen("git config --get remote.origin.url")
--     if not handle then print('Failed to get git remote URL') return end
--
--     local repo_url = handle:read("*a")
--     if not repo_url then print('No remote URL found') return end
--
--     repo_url = repo_url:gsub("%s+", "") -- trim whitespace/newlines
--     handle:close()
--
--     local token = os.getenv("GIT_TOKEN")
--     if not token then print('Failed to get $GIT_TOKEN environment variable') return end
--
--     local command = '!git push https://luckytoaster'.. ':' .. token .. '@' .. repo_url:sub(9)
--     vim.cmd(command)
-- end
--
-- -- My other mappings
-- keymap.set('n', '<leader>a', 'i⇒<ESC>', { desc = 'Paste a right arrow character' })
-- keymap.set('n', '<leader>gs', '<cmd>!git status<cr>', { desc = 'Git status' })
-- keymap.set('n', '<leader>ga', '<cmd>!git add .<cr>', { desc = 'Git add' })
-- keymap.set('n', '<leader>gc', gitCommit, { desc = 'Git commit' })
-- keymap.set('n', '<leader>gp', gitPush, { desc = 'Git push' })
--
