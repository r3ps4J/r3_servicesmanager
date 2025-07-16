local function EventEmitter()
    ---@class EventEmitter
    local eventEmitter = {}

    ---@class Listener
    ---@field invokingResource string
    ---@field callback function
    ---@field onResourceStop EventHandler | nil

    ---@class Subscription
    ---@field unsubscribe fun(): nil

    ---@type Listener[]
    local listeners = {}

    ---@param callback function
    ---@return Subscription
    function eventEmitter.subscribe(callback)
        ---@type Listener
        local listener = {
            invokingResource = GetInvokingResource(),
            callback = callback,
            onResourceStop = nil,
        }

        local index = #listeners + 1
        listeners[index] = listener

        local unsubscribed = false
        local function unsubscribe()
            if unsubscribed then
                return
            end
            RemoveEventHandler(listener.onResourceStop)
            listeners[index] = nil
            unsubscribed = true
        end

        listener.onResourceStop = AddEventHandler("onResourceStop", function(resourceName)
            if resourceName ~= listener.invokingResource then
                return
            end
            unsubscribe()
        end)

        return { unsubscribe = unsubscribe }
    end

    ---@param value any
    function eventEmitter.emit(value)
        for _, listener in pairs(listeners) do
            if listener ~= nil then
                listener.callback(value)
            end
        end
    end

    return eventEmitter
end

return EventEmitter
