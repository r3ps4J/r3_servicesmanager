---Parses a version string into the MAJOR.MINOR.PATCH format.
---@param version string
---@return string
local function parseVersion(version)
    -- stylua: ignore
    return version:match("%d+%.%d+%.%d+")
end

---Returns the current version of this resource or false if it couldn't be determined.
---@return string | false
local function getResourceVersion()
    local currentVersion <const> = GetResourceMetadata("r3_servicesmanager", "version", 0)
    if not currentVersion then
        return false
    end
    return parseVersion(currentVersion)
end

local function versionCheck()
    if GetConvarInt("r3_servicesmanager:versionCheck", 1) == 0 then
        return
    end

    local currentVersion <const> = getResourceVersion()
    if not currentVersion then
        -- stylua: ignore
        print("^3Could not determine r3_servicesmanager resource version, version check aborted.^0")
    end

    PerformHttpRequest(
        "https://api.github.com/repos/r3ps4J/r3_servicesmanager/releases/latest",
        function(errorCode, resultData)
            if errorCode ~= 200 then
                return
            end

            local data <const> = json.decode(resultData)
            local latestVersion = parseVersion(data["tag_name"])
            if latestVersion == currentVersion then
                return
            end

            print(
                ("^3An update is available for r3_servicesmanager (current version: %s, latest version: %s)^0"):format(
                    currentVersion,
                    latestVersion
                )
            )
        end
    )
end

return versionCheck
