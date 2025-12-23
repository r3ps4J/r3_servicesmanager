RegisterOnResourceStart("progress", function()
    local QBCore = exports["qb-core"]:GetCoreObject({ "Functions" })
    local wasCancelled = false

    ---@type ClientProgressProvider
    local progressProvider = {
        startProgress = function(label, duration, options)
            wasCancelled = false
            local animation = {}

            if options?.animation then
                animation = {
                    animDict = options.animation.dict,
                    anim = options.animation.clip,
                }
            elseif options?.scenario then
                animation = {
                    task = options.scenario,
                }
            end

            QBCore.Functions.Progressbar(
                "", -- Name is not actually used internally so we can hardcode it to ""
                label,
                duration,
                false, -- useWhileDead
                true, -- canCancel
                {
                    disableMovement = options?.disable.movement,
                    disableCarMovement = options?.disable.vehicleMovement,
                    disableMouse = options?.disable.mouse,
                    disableCombat = options?.disable.combat,
                },
                animation,
                {}, -- prop
                {}, -- propTwo
                function()
                    -- Since we cannot cancel a progressbar in qbcore
                    if wasCancelled then
                        options?.onCancel()
                        return
                    end
                    options?.onFinish()
                end,
                options?.onCancel
            )
        end,
        cancelProgress = function()
            -- Since we cannot cancel a progressbar in qbcore
            wasCancelled = true
            -- stylua: ignore
            TriggerEvent("progressbar:client:cancel")
        end,
    }

    return progressProvider
end, ServicePriority.Lowest, "qb-core")
