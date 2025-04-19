local set = function(mode, keys, action, description)
    vim.keymap.set(mode, keys, action, { desc = description })
end

set("i", "df", "<ESC>", "Exit insert mode with 'df'")
set('t', 'df', '<C-\\><C-n>', "Exit insert mode when in terminal mode")
set("n", "<leader>nh", "<cmd>nohl<CR>", "no highlight, clear search highlights")
set('n', '<leader>a', 'i⇒<ESC>', 'Paste a right arrow character')

-- GIT
local git = require('misc').git
set('n', '<leader>gc', git.commit, 'Git commit')
set('n', '<leader>gp', git.push, 'Git push')
set('n', '<leader>gs', '<cmd>!git status<cr>', 'Git status')
set('n', '<leader>ga', '<cmd>!git add .<cr>', 'Git add')

-- BUFFERS
set('n', '<leader>n', '<cmd>enew<cr>', "open a new empty buffer")
set('n', '<leader>w', '<cmd>bd!<cr>', "Close / delete current buffer")
set('n', '<leader>t', '<cmd>term<cr>', "Open a terminal buffer")
set('n', '<leader>l', '<cmd>bnext<cr>', "Switch to next open buffer")
set('n', '<leader>h', '<cmd>bprev<cr>', "Switch to previous open buffer")

-- SPLITS
set('n', '<leader>s', '<cmd>vs | enew<cr>', "Open new buffer in a vertical split")
set('n', '<C-h>', '<C-w>h', "navigate splits with 'control + hjkl'")
set('n', '<C-j>', '<C-w>j', "navigate splits with 'control + hjkl'")
set('n', '<C-k>', '<C-w>k', "navigate splits with 'control + hjkl'")
set('n', '<C-l>', '<C-w>l', "navigate splits with 'control + hjkl'")
set('n', '<C-left>', '<cmd>vertical resize +4<CR>', "resize splits with 'control + arrow keys'")
set('n', '<C-right>', '<cmd>vertical resize -4<CR>', "resize splits with 'control + arrow keys'")
set('n', '<C-up>', '<cmd>horizontal resize +4<CR>', "resize splits with 'control + arrow keys'")
set('n', '<C-down>', '<cmd>horizontal resize -4<CR>', "resize splits with 'control + arrow keys'")

-- LSP
vim.api.nvim_create_autocmd('LspAttach', {
    desc = 'LSP actions',
    callback = function(event)
        local opts = { buffer = event.buf }
        vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
        vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
        vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
        vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
        vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
        vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
        vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
        vim.keymap.set('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
        vim.keymap.set({ 'n', 'x' }, '<F3>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)
        vim.keymap.set('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
    end,
})

-- nvim-tree
set('n', '<leader>ft', '<cmd>NvimTreeToggle<cr>', 'Toggle Nvim Tree')

-- FZF-LUA
set('n', '<leader>ff', '<Cmd>FzfLua files<cr>', "Fuzzy find files from CWD")
set('n', '<leader>fh', '<Cmd>FzfLua files cwd=/home/lucky/<CR>', "Fuzzy find files from ~")
set('n', '<leader>fb', '<Cmd>FzfLua buffers<cr>', "Fuzzy find open buffers")
set('n', '<leader>fg', '<Cmd>FzfLua grep<cr>', "Fuzzy find using grep")

-- GITSIGNS 
set('n', '<leader>gb', '<cmd>Gitsigns toggle_current_line_blame<CR>', "view changed lines")
set('n', '<leader>gv', '<Cmd>Gitsigns preview_hunk_inline<CR>', "view changed lines")
set('n', '<leader>gk', '<Cmd>Gitsigns prev_hunk<CR><Cmd>Gitsigns preview_hunk_inline<CR>', "view changed lines")
set('n', '<leader>gj', '<Cmd>Gitsigns next_hunk<CR><Cmd>Gitsigns preview_hunk_inline<CR>', "view changed lines")

-- DAP UI
local dapui = require('dapui')
set('n', '<leader>do', dapui.open, 'open debugger ui')
set('n', '<leader>dc', dapui.close, 'clsoe debugger ui')
set('n', '<leader>dd', dapui.toggle, 'toggle debugger ui')

