RegisterOnResourceStart("progress", function()
    ---@type ClientProgressProvider
    local progressProvider = {
        startProgress = function(label, duration, options)
            local data = {
                label = label,
                duration = duration,
                canCancel = true,
            }

            if options?.animation then
                data.anim = {
                    dict = options.animation.dict,
                    lib = options.animation.clip,
                }
            elseif options?.scenario then
                data.anim = {
                    scenario = options.scenario,
                }
            end

            if options?.disable then
                data.disable = {
                    move = options.disable.movement,
                    car = options.disable.vehicleMovement,
                    combat = options.disable.combat,
                    mouse = options.disable.mouse,
                }
            end

            if exports.ox_lib:progressBar(data) then
                options?.onFinish()
            else
                options?.onCancel()
            end
        end,
        cancelProgress = function()
            exports.ox_lib:cancelProgress()
        end,
    }

    return progressProvider
end, ServicePriority.Low, "ox_lib")
