local set = function(mode, keys, action, description)
    vim.keymap.set(mode, keys, action, { desc = description })
end

set("i", "df", "<ESC>", "Exit insert mode with 'df'")
set('t', 'df', '<C-\\><C-n>', "Exit insert mode when in terminal mode")
set("n", "<leader>nh", "<cmd>nohl<CR>", "no highlight, clear search highlights")
set('n', '<leader>a', 'i⇒<ESC>', 'Paste a right arrow character')
set('n', '<leader>cd', ':cd %:p:h<CR>:pwd<CR>', 'CD to current file')

set('n', '<F5>', ':!python %<CR>', 'Run current python file')

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
        --local opts = { buffer = event.buf, desc = 'LSP: ' .. description}
        local function desc(description)
            return { buffer = event.buf, desc = 'LSP: ' .. description }
        end
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, desc('Go to definition'))
        vim.keymap.set('n', '<leader>d',  vim.lsp.buf.hover, desc('Hover documentation'))
        vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, desc('Refactor / rename'))
        vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, desc('Code action'))
        vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, desc(' Show Error / Warning '))
        vim.keymap.set('n', ']d', vim.diagnostic.goto_next, desc('Go to next diagnostic'))
        vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, desc('Go to prev diagnostic'))
    end,
})

-- nvim-tree
set('n', '<leader>ft', '<cmd>NvimTreeToggle<cr>', 'Toggle Nvim Tree')

-- FZF-LUA
set('n', '<leader>ff', '<Cmd>FzfLua files<cr>', "Fuzzy find files from CWD")
set('n', '<leader>fh', '<Cmd>FzfLua files cwd=/home/lucky/<CR>', "Fuzzy find files from ~")
set('n', '<leader>fg', '<Cmd>FzfLua rg<cr>', "Fuzzy find using ripgrep")

-- GITSIGNS 
set('n', '<leader>gb', '<cmd>Gitsigns toggle_current_line_blame<CR>', "git blame")
set('n', '<leader>gv', '<Cmd>Gitsigns preview_hunk_inline<CR>', "view hunk")
set('n', '<leader>gk', '<Cmd>Gitsigns prev_hunk<CR><Cmd>Gitsigns preview_hunk_inline<CR>', "view previous hunk")
set('n', '<leader>gj', '<Cmd>Gitsigns next_hunk<CR><Cmd>Gitsigns preview_hunk_inline<CR>', "view next hunk")
