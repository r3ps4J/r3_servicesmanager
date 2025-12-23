---@class ProgressOptions
---@field disable? { movement?: boolean, vehicleMovement?: boolean, mouse?: boolean, combat?: boolean }
---@field animation? { dict: string, clip: string }
---@field scenario? string
---@field onFinish? fun(): nil
---@field onCancel? fun(): nil

---@class ClientProgressProvider
---@field startProgress fun(label: string, duration: integer, options?: ProgressOptions): nil
---@field cancelProgress fun(): nil
