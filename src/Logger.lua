-- Edited from https://github.com/rxi/log.lua

local isDuplicityVersion = IsDuplicityVersion()

---Constructs a logger for the current class/function
---@param className? string
---@return Logger
local function Logger(className)
    ---@class Logger
    ---@field trace fun(...)
    ---@field debug fun(...)
    ---@field info fun(...)
    ---@field warn fun(...)
    ---@field error fun(...)
    ---@field fatal fun(...)
    local logger = { _version = "0.1.0" }

    if className == nil then
        className = debug.getinfo(2, "n").name
    end

    local modes = {
        { name = "trace", color = "\27[34m" },
        { name = "debug", color = "\27[36m" },
        { name = "info", color = "\27[32m" },
        { name = "warn", color = "\27[33m" },
        { name = "error", color = "\27[31m" },
        { name = "fatal", color = "\27[35m" },
    }

    local levels = {}
    for i, v in ipairs(modes) do
        levels[v.name] = i
    end

    logger.useColor = isDuplicityVersion
    logger.level = "info"
    logger.showTimestamp = isDuplicityVersion

    local useColor = GetConvar(
        ("r3_servicesmanager:logger:useColor:%s"):format(className),
        GetConvar("r3_servicesmanager:logger:useColor", "1")
    )
    if useColor == "0" or useColor == "false" then
        logger.useColor = false
    end

    local logLevel = GetConvar(
        ("r3_servicesmanager:logger:logLevel:%s"):format(className),
        GetConvar("r3_servicesmanager:logger:logLevel", "info")
    )
    if levels[logLevel] ~= nil then
        logger.level = logLevel
    end

    local round = function(x, increment)
        increment = increment or 1
        x = x / increment
        return (x > 0 and math.floor(x + 0.5) or math.ceil(x - 0.5)) * increment
    end

    local _tostring = tostring

    local tostring = function(...)
        local t = {}
        for i = 1, select("#", ...) do
            local x = select(i, ...)
            if type(x) == "number" then
                x = round(x, 0.01)
            end
            t[#t + 1] = _tostring(x)
        end
        return table.concat(t, " ")
    end

    for i, x in ipairs(modes) do
        local nameUpper = x.name:upper()
        ---@type fun(...)
        logger[x.name] = function(...)
            -- Return early if we're below the log level
            if i < levels[logger.level] then
                return
            end

            local message = tostring(...)

            -- Output to console
            -- stylua: ignore
            print(string.format(
                logger.showTimestamp and "%s[%-6s%s]%s %s: %s" or "%s[%s%s]%s %s: %s",
                logger.useColor and x.color or "",
                nameUpper,
                logger.showTimestamp and os.date("%H:%M:%S") or "",
                logger.useColor and "\27[0m" or "",
                className,
                message
            ))
        end
    end

    return logger
end

return Logger
