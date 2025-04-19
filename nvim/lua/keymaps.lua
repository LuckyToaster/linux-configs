-- ======================================================================================================
-- = KEYMAPS ============================================================================================
-- ======================================================================================================

local keymap = vim.keymap

keymap.set("i", "df", "<ESC>", { desc = "Exit insert mode with 'df'" })
keymap.set('t', 'df', '<C-\\><C-n>', { desc = "Exit insert mode when in terminal mode" })
keymap.set("n", "<leader>nh", "<cmd>nohl<CR>", { desc = "no highlight, clear search highlights" })
-- BUFFERS
keymap.set('n', '<leader>n', '<cmd>enew<cr>', { desc = "open a new empty buffer" })
keymap.set('n', '<leader>w', '<cmd>bd!<cr>', { desc = "Close / delete current buffer" })
keymap.set('n', '<leader>t', '<cmd>term<cr>', { desc = "Open a terminal buffer" })
keymap.set('n', '<leader>l', '<cmd>bnext<cr>', { desc = "Switch to next open buffer" })
keymap.set('n', '<leader>h', '<cmd>bprev<cr>', { desc = "Switch to previous open buffer" })
-- SPLITS
keymap.set('n', '<leader>s', '<cmd>vs | enew<cr>', { desc = "Open new buffer in a vertical split" })
keymap.set('n', '<C-h>', '<C-w>h', { desc = "navigate splits with 'control + hjkl'" })
keymap.set('n', '<C-j>', '<C-w>j', { desc = "navigate splits with 'control + hjkl'" })
keymap.set('n', '<C-k>', '<C-w>k', { desc = "navigate splits with 'control + hjkl'" })
keymap.set('n', '<C-l>', '<C-w>l', { desc = "navigate splits with 'control + hjkl'" })
keymap.set('n', '<C-left>', '<cmd>vertical resize +4<CR>', { desc = "resize splits with 'control + arrow keys'" })
keymap.set('n', '<C-right>', '<cmd>vertical resize -4<CR>', { desc = "resize splits with 'control + arrow keys'" })
keymap.set('n', '<C-up>', '<cmd>horizontal resize +4<CR>', { desc = "resize splits with 'control + arrow keys'" })
keymap.set('n', '<C-down>', '<cmd>horizontal resize -4<CR>', { desc = "resize splits with 'control + arrow keys'" })
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
keymap.set('n', '<leader>ft', '<cmd>NvimTreeToggle<cr>', { noremap = true, silent = true })
keymap.set('n', '?', '<cmd>NvimTreeToggleHelp<cr>', { noremap = true, silent = true })

-- FZF-LUA
require('fzf-lua').setup({ 'border-fused' })
keymap.set('n', '<leader>ff', '<Cmd>FzfLua files<cr>', { desc = "fuzzy find files from CWD" })
keymap.set('n', '<leader>fh', '<Cmd>FzfLua files cwd=/home/lucky/<CR>', { desc = "fuzzy find files from ~" })
keymap.set('n', '<leader>fb', '<Cmd>FzfLua buffers<cr>', { desc = "fuzzy find open buffers" })
keymap.set('n', '<leader>fg', '<Cmd>FzfLua grep<cr>', { desc = "fuzzy find using grep" })

-- GITSIGNS 
keymap.set('n', '<leader>gb', '<cmd>Gitsigns toggle_current_line_blame<CR>', { desc = "view changed lines" })
keymap.set('n', '<leader>gv', '<Cmd>Gitsigns preview_hunk_inline<CR>', { desc = "view changed lines" })
keymap.set('n', '<leader>gk', '<Cmd>Gitsigns prev_hunk<CR><Cmd>Gitsigns preview_hunk_inline<CR>', { desc = "view changed lines" })
keymap.set('n', '<leader>gj', '<Cmd>Gitsigns next_hunk<CR><Cmd>Gitsigns preview_hunk_inline<CR>', { desc = "view changed lines" })

-- disable terminal numbers in terminal mode
vim.api.nvim_create_autocmd("TermOpen", {
    pattern = "*",
    callback = function()
        vim.opt_local.number = false         -- Disable absolute line numbers
        vim.opt_local.relativenumber = false -- Disable relative line numbers
    end,
})

local gitCommit = function()
    vim.ui.input({ prompt = 'Commit Message: ' }, function(msg) if msg then vim.cmd('!git commit -m "' .. msg .. '"') end end)
end


local gitPush = function()
    local handle = io.popen("git config --get remote.origin.url")
    if not handle then print('Failed to get git remote URL') return end

    local repo_url = handle:read("*a")
    if not repo_url then print('No remote URL found') return end

    repo_url = repo_url:gsub("%s+", "") -- trim whitespace/newlines
    handle:close()

    local token = os.getenv("GIT_TOKEN")
    if not token then print('Failed to get $GIT_TOKEN environment variable') return end

    local command = '!git push https://luckytoaster'.. ':' .. token .. '@' .. repo_url:sub(9)
    vim.cmd(command)
end

-- My other mappings
keymap.set('n', '<leader>a', 'i⇒<ESC>', { desc = 'Paste a right arrow character' })
keymap.set('n', '<leader>gs', '<cmd>!git status<cr>', { desc = 'Git status' })
keymap.set('n', '<leader>ga', '<cmd>!git add .<cr>', { desc = 'Git add' })
keymap.set('n', '<leader>gc', gitCommit, { desc = 'Git commit' })
keymap.set('n', '<leader>gp', gitPush, { desc = 'Git push' })

