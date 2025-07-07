RegisterOnResourceStart("employment", function()
    local QBCore = exports["qb-core"]:GetCoreObject({ "Functions", "Shared" })

    ---@type ServerEmploymentProvider
    local employmentProvider

    employmentProvider = {
        getJob = function(jobName)
            local qbJob = QBCore.Shared.Jobs[jobName]
            if qbJob == nil then
                return nil
            end

            local label = qbJob.label
            ---@type table<integer, JobGrade>
            local grades = {}

            for grade, qbJobGrade in pairs(qbJob.grades) do
                grades[grade] = {
                    name = qbJobGrade.name, -- qbcore doesn't differentiate between grade name and grade label
                    label = qbJobGrade.name,
                    salary = qbJobGrade.payment,
                    isBoss = qbJobGrade.isboss ~= nil and qbJobGrade.isboss,
                }
            end

            return {
                name = jobName,
                label = label,
                grades = grades,
            }
        end,
        jobExists = function(jobName, jobGrade)
            local qbJob = QBCore.Shared.Jobs[jobName]
            if qbJob == nil then
                return false
            end

            if jobGrade ~= nil and qbJob.grades[jobGrade] == nil then
                return false
            end

            return true
        end,
        getOnlineJobCount = function(jobName)
            return QBCore.Functions.GetDutyCount(jobName)
        end,
        getPlayerJob = function(playerId)
            local Player = QBCore.Functions.GetPlayer(playerId)
            if not Player then
                return nil
            end

            local playerJob = Player.PlayerData.job

            return {
                name = playerJob.name,
                label = playerJob.label,
                grade = {
                    rank = playerJob.grade.level,
                    name = playerJob.grade.name, -- qbcore doesn't differentiate between grade name and grade label
                    label = playerJob.grade.name,
                    salary = playerJob.payment,
                    isBoss = playerJob.isboss,
                },
            }
        end,
        setPlayerJob = function(playerId, jobName, jobGrade)
            local Player = QBCore.Functions.GetPlayer(playerId)
            if not Player then
                return false
            end

            return Player.Functions.SetJob(jobName, jobGrade)
        end,
        playerHasJob = function(playerId, jobName, jobGrade)
            local Player = QBCore.Functions.GetPlayer(playerId)
            if not Player then
                return false
            end

            local playerJob = Player.PlayerData.job

            if playerJob.name ~= jobName then
                return false
            end

            if jobGrade ~= nil and playerJob.grade.level < jobGrade then
                return false
            end

            return true
        end,
    }

    return employmentProvider
end, ServicePriority.Lowest, "qb-core")
