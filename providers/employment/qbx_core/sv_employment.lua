RegisterOnResourceStart("employment", function()
    ---@type ServerEmploymentProvider
    local employmentProvider

    employmentProvider = {
        getJob = function(jobName)
            local qbxJob = exports.qbx_core:GetJob(jobName)
            if qbxJob == nil then
                return nil
            end

            local label = qbxJob.label
            ---@type table<integer, JobGrade>
            local grades = {}

            for grade, qbxJobGrade in pairs(qbxJob.grades) do
                grades[grade] = {
                    name = qbxJobGrade.name, -- qbox doesn't differentiate between grade name and grade label
                    label = qbxJobGrade.name,
                    salary = qbxJobGrade.payment,
                    isBoss = qbxJobGrade.isboss ~= nil and qbxJobGrade.isboss,
                }
            end

            return {
                name = jobName,
                label = label,
                grades = grades,
            }
        end,
        jobExists = function(jobName, jobGrade)
            local qbxJob = exports.qbox_core.GetJob(jobName)
            if qbxJob == nil then
                return false
            end

            if jobGrade ~= nil and qbxJob.grades[jobGrade] == nil then
                return false
            end

            return true
        end,
        getOnlineJobCount = function(jobName)
            local count, players = exports.qbx_core:GetDutyCountJob(jobName)
            return count
        end,
        getPlayerJob = function(playerId)
            local player = exports.qbx_core:GetPlayer(playerId)
            if player == nil then
                return nil
            end

            local playerJob = player.PlayerData.job

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
        end,
        setPlayerJob = function(playerId, jobName, jobGrade)
            local player = exports.qbx_core:GetPlayer(playerId)
            if player == nil then
                return false
            end

            return exports.qbx_core:SetJob(playerId, jobName, jobGrade)
        end,
        playerHasJob = function(playerId, jobName, jobGrade)
            local player = exports.qbx_core:GetPlayer(playerId)

            if player == nil then
                return false
            end

            local playerJob = player.PlayerData.job

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
end, ServicePriority.Low, "qbx_core")
