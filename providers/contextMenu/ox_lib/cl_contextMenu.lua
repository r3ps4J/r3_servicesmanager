RegisterOnResourceStart("contextMenu", function()
    ---@type ClientContextMenuProvider
    local contextMenuProvider = {
        openMenu = function(options)
            local elements = {}
            for i, menuElement in ipairs(options.elements) do
                elements[#elements + 1] = {
                    title = menuElement.title,
                    description = menuElement.description,
                    icon = menuElement.icon,
                    disabled = menuElement.disabled,
                    onSelect = menuElement.onSelect,
                }
            end

            exports.ox_lib:registerContext({
                id = options.id,
                title = options.title,
                options = elements,
            })
            exports.ox_lib:showContext(options.id)
        end,
        closeMenu = function()
            exports.ox_lib:hideContext()
        end,
    }

    return contextMenuProvider
end, ServicePriority.Low, "ox_lib")
