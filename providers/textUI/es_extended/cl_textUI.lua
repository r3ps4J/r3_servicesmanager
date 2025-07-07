RegisterOnResourceStart("textUI", function()
    local ESX = exports["es_extended"]:getSharedObject()

    ---@type ClientTextUIProvider
    local textUIProvider = {
        showTextUI = function(text)
            ESX.TextUI(text)
        end,
        hideTextUI = function()
            ESX.HideUI()
        end,
    }

    return textUIProvider
end, ServicePriority.Lowest, "es_extended")
