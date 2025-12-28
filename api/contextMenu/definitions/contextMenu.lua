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
--- Gets called when the menu is closed by the user or using closeMenu, can be called when an element was selected but this is provider dependent and not always the case
---@field onClose? fun(): nil

---@class ClientContextMenuProvider
---@field openMenu fun(options: ContextMenuOptions): nil
---@field closeMenu fun(): nil
