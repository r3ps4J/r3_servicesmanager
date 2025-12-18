---@class MenuElement
---@field title string
---@field description? string
--- Full font awesome 5 icon including prefix such as "fas fa-"
---@field icon? string
---@field disabled? boolean
---@field onSelect? fun(): nil

---@class MenuOptions
---@field id string
---@field title string
---@field elements MenuElement[]

---@class ClientContextMenuProvider
---@field openMenu fun(options: MenuOptions): nil
---@field closeMenu fun(): nil
