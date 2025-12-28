---@class ContextMenuElement
---@field title string
---@field description? string
--- Full font awesome 5 icon including prefix such as "fas fa-"
---@field icon? string
---@field disabled? boolean
---@field onSelect? fun(): nil

---@class ContextMenuOptions
---@field id string
---@field title string
---@field elements ContextMenuElement[]
---@field onClose? fun(): nil

---@class ClientContextMenuProvider
---@field openMenu fun(options: ContextMenuOptions): nil
---@field closeMenu fun(): nil
