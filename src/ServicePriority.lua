---@alias ServicePriority 0 | 1 | 2 | 3 | 4

---@type { Lowest: 0, Low: 1, Normal: 2, High: 3, Highest: 4 } | { [0]: "Lowest", [1]: "Low", [2]: "Normal", [3]: "High", [4]: "Highest" }
local ServicePriority = {
    Lowest = 0,
    Low = 1,
    Normal = 2,
    High = 3,
    Highest = 4,
}

local reversedServicePriority = {}
for name, value in pairs(ServicePriority) do
    reversedServicePriority[value] = name
end

setmetatable(ServicePriority, {
    __index = function(t, key)
        return reversedServicePriority[key]
    end,
})

return ServicePriority
