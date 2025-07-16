RegisterOnResourceStart("employment", function()
    local ESX = exports["es_extended"]:getSharedObject()

    local bossGradeName = "boss"

    ---@type ClientEmploymentProvider
    local employmentProvider = {
        getPlayerJob = function()
            local xPlayerJob = ESX.GetPlayerData().job

            return {
                name = xPlayerJob.name,
                label = xPlayerJob.label,
                grade = {
                    rank = xPlayerJob.grade,
                    name = xPlayerJob.grade_name,
                    label = xPlayerJob.grade_label,
                    salary = xPlayerJob.grade_salary,
                    isBoss = xPlayerJob.grade_name == bossGradeName,
                },
            }
        end,
        playerHasJob = function(jobName, jobGrade)
            local xPlayerJob = ESX.GetPlayerData().job

            if xPlayerJob.name ~= jobName then
                return false
            end

            if jobGrade ~= nil and xPlayerJob.grade < jobGrade then
                return false
            end

            return true
        end,
    }

    return employmentProvider
end, ServicePriority.Lowest, "es_extended")
