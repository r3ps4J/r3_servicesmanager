---@param tbl table
---@param element any
---@return boolean
local function table_contains(tbl, element)
    for _, value in pairs(tbl) do
        if value == element then
            return true
        end
    end
    return false
end

return table_contains
