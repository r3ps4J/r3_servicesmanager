local ServicePriority = require "ServicePriority"
local table_contains = require "utils.table_contains"

---The constructor for the RegisteredProvider class.
---@param service string
---@param provider table
---@param priority number
---@param resource string
---@return RegisteredProvider
function RegisteredProvider(service, provider, priority, resource)
    assert(service ~= nil, "service cannot be nil")
    assert(provider ~= nil, "provider cannot be nil")
    assert(priority ~= nil, "priority cannot be nil")
    assert(resource ~= nil, "resource cannot be nil")

    assert(type(service) == "string", "service must be a string")
    assert(type(provider) == "table", "provider must be a table")
    assert(table_contains(ServicePriority, priority), "priority must be a valid ServicePriority")
    assert(type(resource) == "string", "resource must be a string")

    ---@class RegisteredProvider
    local registeredProvider = {}

    local service = service
    local provider = provider
    local priority = priority
    local resource = resource

    function registeredProvider:getService()
        return service
    end

    function registeredProvider:getProvider()
        return provider
    end

    function registeredProvider:getPriority()
        return priority
    end

    function registeredProvider:getResource()
        return resource
    end

    return registeredProvider
end

return RegisteredProvider
