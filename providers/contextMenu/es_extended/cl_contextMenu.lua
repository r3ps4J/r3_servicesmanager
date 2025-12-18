RegisterOnResourceStart("menu", function()
    local ESX = exports["es_extended"]:getSharedObject()

    ---@type ClientContextMenuProvider
    local contextMenuProvider = {
        openMenu = function(options)
            local elements = {
                {
                    title = options.title,
                    unselectable = true,
                },
            }
            for i, menuElement in ipairs(options.elements) do
                elements[#elements + 1] = {
                    title = menuElement.title,
                    description = menuElement.description,
                    icon = menuElement.icon,
                    disabled = menuElement.disabled,
                    onSelect = menuElement.onSelect,
                }
            end

            ESX.OpenContext("right", elements, function(menu, element)
                if element.onSelect then
                    element.onSelect()
                end
            end)
        end,
        closeMenu = ESX.CloseContext,
    }

    return contextMenuProvider
end, ServicePriority.Lowest, "es_extended")
