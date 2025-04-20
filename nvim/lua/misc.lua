local M = {}
M.git = {}

M.autocmds = function ()
    -- disable terminal numbers in terminal mode
    vim.api.nvim_create_autocmd("TermOpen", {
        pattern = "*",
        callback = function()
            vim.opt_local.number = false         -- Disable absolute line numbers
            vim.opt_local.relativenumber = false -- Disable relative line numbers
        end,
    })

    -- Make sure :help always opens in new buffer in current window (same as ':help something | only')
    -- vim.api.nvim_create_autocmd("FileType", {
    --     pattern = "help",
    --     callback = function()
    --         vim.cmd("only")
    --     end
    -- })
end


-- commit to git function
M.git.commit = function()
    vim.ui.input({ prompt = 'Commit Message: ' }, function(msg) if msg then vim.cmd('!git commit -m "' .. msg .. '"') end end)
end


-- push to git function
M.git.push = function()
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

return M
