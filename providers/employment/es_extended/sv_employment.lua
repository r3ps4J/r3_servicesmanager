RegisterOnResourceStart("employment", function()
    local ESX = exports["es_extended"].getSharedObject()

    local bossGradeName = "boss"

    ---@type ServerEmploymentProvider
    local employmentProvider = {
        getJob = function(jobName)
            local esxJob = ESX.GetJobs()[jobName]

            if esxJob == nil then
                return nil
            end

            local label = esxJob.label
            ---@type table<integer, JobGrade>
            local grades = {}

            for grade, esxJobGrade in pairs(esxJob.grades) do
                grades[grade] = {
                    name = esxJob.name,
                    label = esxJobGrade.label,
                    salary = esxJob.salary,
                    isBoss = esxJob.name == bossGradeName,
                }
            end

            return {
                name = jobName,
                label = label,
                grades = grades,
            }
        end,
        jobExists = function(jobName, jobGrade)
            local esxJob = ESX.GetJobs()[jobName]

            if esxJob == nil then
                return false
            end

            if jobGrade ~= nil and esxJob.grades[jobGrade] == nil then
                return false
            end

            return true
        end,
        getOnlineJobCount = function(jobName)
            local xPlayers = ESX.GetExtendedPlayers("job", jobName)
            return #xPlayers
        end,
        getPlayerJob = function(playerId)
            local xPlayer = ESX.GetPlayerFromId(playerId)

            if xPlayer == nil then
                return nil
            end

            local xPlayerJob = xPlayer.getJob()

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
        setPlayerJob = function(playerId, jobName, jobGrade)
            local xPlayer = ESX.GetPlayerFromId(playerId)

            if xPlayer == nil then
                return false
            end

            if not ESX.DoesJobExist(jobName, jobGrade) then
                return false
            end

            xPlayer.setJob(jobName, jobGrade)

            return true
        end,
        playerHasJob = function(playerId, jobName, jobGrade)
            local xPlayer = ESX.GetPlayerFromId(playerId)

            if xPlayer == nil then
                return false
            end

            local xPlayerJob = xPlayer.getJob()

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
