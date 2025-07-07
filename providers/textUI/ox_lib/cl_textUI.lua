RegisterOnResourceStart("textUI", function()
    ---@type ClientTextUIProvider
    local textUIProvider = {
        showTextUI = function(text)
            exports.ox_lib:showTextUI(text)
        end,
        hideTextUI = function()
            exports.ox_lib:hideTextUI()
        end,
    }

    return textUIProvider
end, ServicePriority.Low, "ox_lib")
