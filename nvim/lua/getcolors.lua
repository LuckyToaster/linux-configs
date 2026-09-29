local hl_groups = vim.api.nvim_get_hl(0, {})
local result = {}

for name, hl in pairs(hl_groups) do
    -- Only capture groups that actually define a foreground or background color
    if hl.fg or hl.bg then
        result[name] = {
            fg = hl.fg and string.format("#%06x", hl.fg) or "none",
            bg = hl.bg and string.format("#%06x", hl.bg) or "none",
        }
    end
end

-- Dump the dictionary to a JSON file
local file_path = vim.fn.expand("~/.cache/nvim_highlights.json")
local file = io.open(file_path, "w")
if file then
    file:write(vim.fn.json_encode(result))
    file:close()
    print("Highlights exported to: " .. file_path)
else
    print("Failed to open file for writing.")
end
