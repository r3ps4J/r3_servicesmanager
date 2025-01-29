local ServicesManager = require "ServicesManager"

local servicesManager = ServicesManager()

exports("register", servicesManager.register)
exports("load", servicesManager.load)
exports("getRegistration", servicesManager.getRegistration)
exports("getRegistrationsForService", servicesManager.getRegistrationsForService)
exports("getRegistrationsForResource", servicesManager.getRegistrationsForResource)
exports("getKnownServices", servicesManager.getKnownServices)
exports("isProvidedFor", servicesManager.isProvidedFor)

AddEventHandler("onResourceStop", servicesManager.unregisterAllForResource)
