RegisterOnResourceStart("contextMenu", function()
    ---@type ClientContextMenuProvider
    local contextMenuProvider = {
        openMenu = function(options)
            ---@type EventHandler
            local closeEventHandler
            local function onClose()
                RemoveEventHandler(closeEventHandler)
                if options.onClose then
                    options.onClose()
                end
            end
            closeEventHandler = AddEventHandler("qb-menu:client:menuClosed", onClose)

            local elements = {
                {
                    header = options.title,
                    isMenuHeader = true,
                },
            }
            for i, menuElement in ipairs(options.elements) do
                elements[#elements + 1] = {
                    header = menuElement.title,
                    txt = menuElement.description,
                    icon = menuElement.icon,
                    disabled = menuElement.disabled,
                    action = menuElement.onSelect,
                }
            end

            exports["qb-menu"]:openMenu({
                id = options.id,
                title = options.title,
                options = elements,
            }, false, false)
        end,
        closeMenu = function()
            exports["qb-menu"]:closeMenu()
            -- qb-menu doesn't trigger their close event when we force close so we have to do it ourselves
            TriggerEvent("qb-menu:client:menuClosed")
        end,
    }

    return contextMenuProvider
end, ServicePriority.Lowest, "qb-menu")
