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
-- autocomplete 
vim.opt.autocomplete = true
vim.opt.completeopt = 'menu,menuone,noselect'
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
vim.opt.signcolumn = "yes"             -- show sign column so that text doesn't shift, you can also: vim.opt.signcolumn = "yes:1"
vim.opt.backspace = "indent,eol,start" -- allow backspace on any of these
vim.opt.scrolloff = 15                 -- when scrolling, prevent cursor from being at first or last line
vim.opt.sidescrolloff = 30
vim.opt.splitright = true
vim.opt.timeoutlen = 300               -- maximum delay to register a keymap
vim.opt.termguicolors = true
vim.opt.updatetime = 250                -- decrease update time
vim.opt.formatoptions:remove({ "c", "r", "o" }) -- stop auto commenting
vim.o.winborder = 'rounded' -- makes all hover / floating windows have rounded borders


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

-- Setup Lazy and plugins
require("lazy").setup({
    rocks = { enabled = false },
    spec = {
        { 'neovim/nvim-lspconfig'},
        { 'nvim-treesitter/nvim-treesitter', build = ':TSUpdate', lazy = false, opts = {}},
        { 'lewis6991/gitsigns.nvim', opts = {} },
        { 'MeanderingProgrammer/render-markdown.nvim', dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' } },
        { 'chomosuke/typst-preview.nvim', lazy = false, version = '1.*', opts = {} },
        { 'Mofiqul/vscode.nvim' },
        { 'morhetz/gruvbox' },
        { 'catppuccin/nvim' },
        {
            'nvim-tree/nvim-tree.lua',
            dependencies = { 'nvim-tree/nvim-web-devicons' },
            opts = { filters = { dotfiles = false }, view = { width = 40 } }
        },
        {
            'ibhagwan/fzf-lua',
            dependencies = { 'nvim-tree/nvim-web-devicons' },
            opts = {
                'border-fused',
                hls = { normal = 'Normal', border = 'FloatBorder' },
                fzf_colors = true -- enable dynamic color generation
            }
        },
        {
            'nvim-lualine/lualine.nvim',
            dependencies = { 'nvim-tree/nvim-web-devicons' },
            opts = {
                options = { theme = 'auto', globalstatus = true },
                sections = {
                    lualine_c = { 'buffers' },
                    lualine_b = { 'diagnostics' }
                },
            }
        },
    },
    checker = { enabled = true }, -- automatically check for plugin updates
})

-- TreeSitter
require('nvim-treesitter').install({"python", "c", "cpp", "rust", "lua", "bash", "typescript", "javascript", "html", "css", "json", "markdown", "markdown_inline", "vim", "vimdoc", "query"})

-- LSP
local servers = { 'basedpyright', 'clangd', 'rust_analyzer', 'bashls', 'jsonls', 'html', 'cssls', 'ts_ls', 'lua_ls', 'tinymist' }
vim.lsp.enable(servers)
vim.lsp.config('basedpyright', {
    settings = {
        basedpyright = {
            analysis = {
                typeCheckingMode = "basic",
                autoSearchPaths = true
            }
        }
    }
})

-- KEYMAPS
local set = function(mode, keys, action, description)
    vim.keymap.set(mode, keys, action, { desc = description })
end

set("i", "df", "<ESC>", "Exit insert mode with 'df'")
set('t', 'df', '<C-\\><C-n>', "Exit insert mode when in terminal mode")
set("n", "<ESC>", "<cmd>nohl<CR>", "Clear search highlights")
set('n', '<leader>cd', ':cd %:p:h<CR>:pwd<CR>', 'CD to current file')
-- BUFFERS
set('n', '<leader>w', '<cmd>bd!<cr>', "Close / delete current buffer")
set('n', '<leader>t', '<cmd>term<cr>', "Open a terminal buffer")
set('n', '<leader>l', '<cmd>bnext<cr>', "Switch to next open buffer")
set('n', '<leader>h', '<cmd>bprev<cr>', "Switch to previous open buffer")
-- Vertical SPLITS
set('n', '<leader>s', '<cmd>vs | enew<cr>', "Open new buffer in a vertical split")
set('n', '<C-h>', '<C-w>h', "navigate splits with 'control + hjkl'")
set('n', '<C-l>', '<C-w>l', "navigate splits with 'control + hjkl'")
-- LSP
vim.api.nvim_create_autocmd('LspAttach', {
    desc = 'LSP actions',
    callback = function(event)
        local function desc(description)
            return { buffer = event.buf, desc = 'LSP: ' .. description }
        end
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, desc('Go to definition'))
        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, desc('Go to implementation'))
        vim.keymap.set('n', '<leader>d',  vim.lsp.buf.hover, desc('Hover documentation'))
        vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, desc('Refactor / rename'))
        vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, desc('Code action'))
        vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, desc(' Show Error / Warning '))

        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if client and client:supports_method('textDocument/completion') then
            vim.lsp.completion.enable(true, client.id, event.buf, { autotrigger = true })
        end
    end,
})

vim.keymap.set('i', '<Tab>', function() return vim.fn.pumvisible() == 1 and '<C-n>' or '<Tab>' end, { expr = true, silent = true })
vim.keymap.set('i', '<S-Tab>', function() return vim.fn.pumvisible() == 1 and '<C-p>' or '<S-Tab>' end, { expr = true, silent = true })
vim.keymap.set('i', '<CR>', function() return vim.fn.pumvisible() == 1 and '<C-y>' or '<CR>' end, { expr = true, silent = true })

-- nvim-tree
set('n', '<leader>ft', '<cmd>NvimTreeToggle<cr>', 'Toggle Nvim Tree')
-- FZF-LUA
set('n', '<leader>ff', '<Cmd>FzfLua files<cr>', "Fuzzy find files from CWD")
set('n', '<leader>fh', '<Cmd>FzfLua files cwd=/home/lucky/<CR>', "Fuzzy find files from ~")
set('n', '<leader>fg', '<Cmd>FzfLua live_grep<cr>', "Fuzzy find using ripgrep")
-- GITSIGNS
set('n', 'gb', '<cmd>Gitsigns toggle_current_line_blame<CR>', "git blame")
set('n', 'gv', '<Cmd>Gitsigns preview_hunk_inline<CR>', "view hunk")
set('n', 'gk', '<Cmd>Gitsigns prev_hunk<CR><Cmd>Gitsigns preview_hunk_inline<CR>', "view previous hunk")
set('n', 'gj', '<Cmd>Gitsigns next_hunk<CR><Cmd>Gitsigns preview_hunk_inline<CR>', "view next hunk")

-- Maps <leader>v to open a vertical split and automatically load the previous buffer alongside it
vim.keymap.set('n', '<leader>v', function()
  vim.cmd('vsplit')
  vim.cmd('wincmd p') -- moves focus to the left window
  vim.cmd('b#')       -- swaps the left window to the previous buffer
  vim.cmd('wincmd p') -- moves focus back to your current buffer on the right
end, { desc = 'Split vertically with previous buffer' })

-- Close nvim-tree before quitting with :q
vim.api.nvim_create_user_command('Q', function()
    local api = require('nvim-tree.api')
    if api.tree.is_visible() then
        api.tree.close()
    end
    vim.cmd('quit')
end, {})

-- Make :q work like :Q
vim.cmd('cabbrev q Q')

require('noctalia_sync')
require('getcolors')
