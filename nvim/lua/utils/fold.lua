---@param items table
---@param line string
---@param row integer
---@param offset? integer
local function virtual_foldtext(items, line, row, offset)
    local col
    if offset then
        col = offset
    else
        col = 0
    end

    local text = ""
    local hl = nil
    for i = 1, #line do
        local char = line:sub(i, i)
        local hls = vim.treesitter.get_captures_at_pos(0, row - 1, col + i - 1) -- 0 based
        local _hl = hls[#hls]
        if _hl then
            local new_hl = "@" .. _hl.capture
            if new_hl == hl then
                text = text .. char
            else
                table.insert(items, { text, hl })
                text = char
                hl = new_hl
            end
        else
            text = text .. char
        end
    end
    table.insert(items, { text, hl })
end

function _G.custom_foldtext()
    local head_line = vim.fn.getline(vim.v.foldstart)
    head_line = head_line:gsub("\t", string.rep(" ", vim.o.tabstop))
    local tail_line = vim.fn.getline(vim.v.foldend)
    tail_line = vim.trim(tail_line)

    local items = {}
    virtual_foldtext(items, head_line, vim.v.foldstart)
    table.insert(items, { " ... ", "Delimiter" })
    virtual_foldtext(items, tail_line, vim.v.foldend, #(tail_line:match("^(%s+)") or ""))
    table.insert(items, { "  󰦨 " .. vim.v.foldend - vim.v.foldstart, "Delimiter" })

    return items
end
