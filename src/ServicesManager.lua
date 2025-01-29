local RegisteredProvider = require "RegisteredProvider"

---The constructor for the ServicesManager class.
---@return ServicesManager
local function ServicesManager()
    ---@class ServicesManager
    local servicesManager = {}

    ---@type table<string, RegisteredProvider[]>
    local providerMap = {}

    ---Sorts the providers for a service in the provider map based on priority.
    ---@param service string
    local function sortProvidersForService(service)
        table.sort(providerMap[service], function(a, b)
            return a:getPriority() > b:getPriority()
        end)
    end

    ---Registers a provider for a service.
    ---@param service string
    ---@param provider table
    ---@param priority number
    ---@param resource string
    function servicesManager.register(service, provider, priority, resource)
        local invokingResource = GetInvokingResource()
        local registeredProvider = RegisteredProvider(service, provider, priority, resource, invokingResource)

        if not providerMap[service] then
            providerMap[service] = {}
        end

        table.insert(providerMap[service], registeredProvider)
        sortProvidersForService(service)

        TriggerEvent("r3_servicesmanager:providerRegistered", registeredProvider)
    end

    ---Returns the provider with the highest priority for a service, or nil if there is none.
    ---@param service string
    ---@return RegisteredProvider | nil
    function servicesManager.load(service)
        return providerMap[service] and providerMap[service][1] or nil
    end

    ---Returns the registered provider with the highest priority for a service, or nil if there is none.
    ---@param service string
    ---@return RegisteredProvider | nil
    function servicesManager.getRegistration(service)
        return providerMap[service] and providerMap[service][1] or nil
    end

    ---Returns all registrations for a service.
    ---@param service string
    ---@return RegisteredProvider[]
    function servicesManager.getRegistrationsForService(service)
        return providerMap[service] or {}
    end

    ---Returns all registrations for a resource.
    ---@param resource string
    ---@return RegisteredProvider[] | nil
    function servicesManager.getRegistrationsForResource(resource)
        local registrations = {}

        for service, providers in pairs(providerMap) do
            for i, provider in ipairs(providers) do
                if provider:getResource() == resource then
                    table.insert(registrations, provider)
                end
            end
        end

        return registrations
    end

    ---Returns a list of services that are registered.
    ---@return table
    function servicesManager.getKnownServices()
        local knownServices = {}
        for service, providers in pairs(providerMap) do
            table.insert(knownServices, service)
        end
        return knownServices
    end

    ---Returns whether or not any provider is registered for a service.
    ---@param service string
    ---@return boolean
    function servicesManager.isProvidedFor(service)
        return providerMap[service] ~= nil and providerMap[service][1] ~= nil
    end

    ---Unregisters all providers registered by a resource.
    ---@param resource string
    function servicesManager.unregisterAllForResource(resource)
        for service, providers in pairs(providerMap) do
            local unregisteredProviders = {}
            for i, provider in ipairs(providers) do
                if provider:getResource() == resource or provider:getInvokingResource() == resource then
                    table.insert(unregisteredProviders, provider)
                    providerMap[service][i] = nil
                end
            end
            if #unregisteredProviders > 0 then
                sortProvidersForService(service)
                for i, provider in ipairs(unregisteredProviders) do
                    TriggerEvent("r3_servicesmanager:providerUnregistered", provider)
                end
            end
        end
    end

    return servicesManager
end

return ServicesManager
