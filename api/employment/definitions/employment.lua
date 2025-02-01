---@class Job
---@field name string
---@field label string
---@field grades table<integer, JobGrade>

---@class PlayerJob
---@field name string
---@field label string
---@field grade PlayerJobGradeData

---@class JobGrade
---@field name string
---@field label string
---@field salary number
---@field isBoss boolean

---@class PlayerJobGradeData : JobGrade
---@field rank integer

---@class ServerEmploymentProvider
---@field getJob fun(jobName: string): Job | nil
---@field jobExists fun(jobName: string, jobGrade?: integer): boolean
---@field getOnlineJobCount fun(jobName: string): integer
---@field getPlayerJob fun(playerId: integer): PlayerJob | nil
---@field setPlayerJob fun(playerId: integer, jobName: string, jobGrade: integer): boolean
---@field playerHasJob fun(playerId: integer, jobName: string, jobGrade: integer): boolean
