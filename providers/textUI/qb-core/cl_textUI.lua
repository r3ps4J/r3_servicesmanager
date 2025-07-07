RegisterOnResourceStart("textUI", function()
    ---@type ClientTextUIProvider
    local textUIProvider = {
        showTextUI = function(text)
            exports["qb-core"]:DrawText(text)
        end,
        hideTextUI = function()
            exports["qb-core"]:HideText()
        end,
    }

    return textUIProvider
end, ServicePriority.Lowest, "qb-core")
