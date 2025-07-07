RegisterOnResourceStart("progress", function()
    local ESX = exports["es_extended"]:getSharedObject()

    ---@type ClientProgressProvider
    local progressProvider = {
        startProgress = function(label, duration, options)
            local esxOptions = {
                FreezePlayer = options.disable?.movement or false,
                onFinish = options.onFinish,
                onCancel = options.onCancel,
            }

            if options.animation then
                esxOptions.animation = {
                    type = "anim",
                    dict = options.animation.dict,
                    lib = options.animation.clip,
                }
            elseif options.scenario then
                esxOptions.animation = {
                    type = "Scenario",
                    Scenario = options.scenario,
                }
            end

            ESX.Progressbar(label, duration, esxOptions)
        end,
        cancelProgress = function()
            ESX.CancelProgressbar()
        end,
    }

    return progressProvider
end, ServicePriority.Lowest, "es_extended")
