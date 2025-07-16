local function EventEmitter()
    ---@class EventEmitter
    local eventEmitter = {}

    ---@class Listener
    ---@field invokingResource string
    ---@field cb function
    ---@field onResourceStop EventHandler | nil

    ---@class ListenerRef
    ---@field eventName string
    ---@field index integer

    ---@type table<string, Listener[]>
    local listeners = {}

    ---@param eventName string
    ---@param cb function
    ---@return ListenerRef
    function eventEmitter.addEventListener(eventName, cb)
        if listeners[eventName] == nil then
            listeners[eventName] = {}
        end

        ---@type Listener
        local listener = {
            invokingResource = GetInvokingResource(),
            cb = cb,
            onResourceStop = nil,
        }

        local index = #listeners[eventName] + 1
        listeners[eventName][index] = listener

        local listenerRef = {eventName = eventName, index = index}

        listener.onResourceStop = AddEventHandler("onResourceStop", function(resourceName)
            if resourceName ~= listener.invokingResource then
                return
            end
            eventEmitter.removeEventListener(listenerRef)
        end)

        return listenerRef
    end

    ---@param ref ListenerRef
    function eventEmitter.removeEventListener(ref)
        local listener = listeners[ref.eventName]?[ref.index]
        if listener == nil then
            return
        end

        RemoveEventHandler(listener.onResourceStop)
        listeners[ref.eventName][ref.index] = nil
    end

    ---@param eventName string
    ---@param value any
    function eventEmitter.emit(eventName, value)
        if listeners[eventName] == nil then
            return
        end

        for _, listener in pairs(listeners[eventName]) do
            if listener ~= nil then
                listener.cb(value)
            end
        end
    end

    return eventEmitter
end

return EventEmitter
