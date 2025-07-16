RegisterOnResourceStart("employment", function()
    local eventEmitter = EventEmitter()

    local function convertJob(playerJob)
        return {
            name = playerJob.name,
            label = playerJob.label,
            grade = {
                rank = playerJob.grade.level,
                name = playerJob.grade.name, -- qbox doesn't differentiate between grade name and grade label
                label = playerJob.grade.name,
                salary = playerJob.payment,
                isBoss = playerJob.isboss,
            },
        }
    end

    ---@type ClientEmploymentProvider
    local employmentProvider = {
        getPlayerJob = function()
            local playerJob = exports.qbx_core:GetPlayerData().job
            return convertJob(playerJob)
        end,
        playerHasJob = function(jobName, jobGrade)
            local playerJob = exports.qbx_core:GetPlayerData().job

            if playerJob.name ~= jobName then
                return false
            end

            if jobGrade ~= nil and playerJob.grade.level < jobGrade then
                return false
            end

            return true
        end,
        onPlayerJobChanged = function(callback)
            eventEmitter.subscribe(callback)
        end,
    }

    RegisterNetEvent("QBCore:Client:OnJobUpdate", function(playerJob)
        eventEmitter.emit(convertJob(playerJob))
    end)

    return employmentProvider
end, ServicePriority.Low, "qbx_core")
