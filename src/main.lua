local ServicesManager = require "ServicesManager"

local servicesManager = ServicesManager()

exports("register", servicesManager.register)
exports("load", servicesManager.load)
exports("getRegistration", servicesManager.getRegistration)
exports("getRegistrationsForService", servicesManager.getRegistrationsForService)
exports("getRegistrationsForResource", servicesManager.getRegistrationsForResource)
exports("getKnownServices", servicesManager.getKnownServices)
exports("isProvidedFor", servicesManager.isProvidedFor)

AddEventHandler("onResourceStop", servicesManager.unregisterAllForResource)

-- Register global values for use in providers
ServicePriority = require "ServicePriority"

---Registers a provider created by a factory function when the specified resource starts.
---@param service string
---@param createProvider fun(): table
---@param priority ServicePriority
---@param resource string
function RegisterOnResourceStart(service, createProvider, priority, resource)
    local function registerProvider()
        local provider = createProvider()
        servicesManager.register(service, provider, priority, resource)
    end

    if GetResourceState(resource) == "started" then
        registerProvider()
    end

    AddEventHandler("onResourceStart", function(resourceName)
        if resourceName ~= resource then
            return
        end

        registerProvider()
    end)
end
