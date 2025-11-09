RegisterOnResourceStart("menu", function()
    ---@type ClientMenuProvider
    local menuProvider = {
        openMenu = function(options)
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
        end,
    }

    return menuProvider
end, ServicePriority.Lowest, "qb-menu")
