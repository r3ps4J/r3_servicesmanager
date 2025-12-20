# r3_servicesmanager
![](https://img.shields.io/github/downloads/r3ps4J/r3_servicesmanager/total?logo=github)
![](https://img.shields.io/github/downloads/r3ps4J/r3_servicesmanager/latest/total?logo=github)
![](https://img.shields.io/github/contributors/r3ps4J/r3_servicesmanager?logo=github)
![](https://img.shields.io/github/v/release/r3ps4J/r3_servicesmanager?logo=github) 

A services manager for the CitizenFX platform. It keeps track of various providers, all registered for a specific service. Scripts can retrieve a registered provider, which implement a specific interface, and use it without knowing anything about the implementation of the provider itself. It is inspired by the popular Minecraft server plugin Vault.

## 📚 Documentation

https://r3ps4j.github.io/r3_servicesmanager

## 💾 Download

https://github.com/r3ps4J/r3_servicesmanager/releases/latest/download/r3_servicesmanager.zip

## Why r3_servicesmanager?
If you've ever wanted to make a resource for FiveM and published it, you probably got the question to support \<insert any framework here\>. And if you've ever made a server and installed a lot of resources on it, you probably ran into "bridge"-like resources which handled the compatibility with frameworks.

r3_servicesmanager provides a solution for this. It gives developers a way to support many different frameworks (and other scripts) without having to program support for each one. Resources can simply register themselves and, as long as they implement the defined interfaces, will be compatible with every script utilising r3_servicesmanager for its dependencies.

Some features of the services manager:
- You no longer need to create many if statements for every framework you want to be compatible with, just retrieve the provider and call the method you need.
- No need to figure out which provider you need. The services manager always gives you the registered provider with the highest priority for which the required resource is started.
- Any resource can make itself compatible, no need to update your script to add support. This also means that you don't need to update your resource when \<insert any resource\> has an update, the provider simply needs to be updated and it will be compatible again!
- Server owners can choose what to use! Since the providers are returned based on a priority, you can increase the priority of your preferred \<framework, progressbar, etc.\> and it will be used in every script utilising this. And you can also swap out resources (as long as they are compatible with this), for example if you want to switch the style of notifications in your server you can remove the old notification script and put in a new one which will then be used instead.

## What is supported?
Pretty much anything can register itself under a service key, but to keep things clear I've defined some interfaces for common services (notifications, jobs, frameworks, etc.). These can all be found in the [`api`](./api/) folder of this repository. Type definitions in Lua and TypeScript can be found there as well. If you need an API for a service that is not defined, make an issue! I'll check if I can define it if it's commonly used.

There are some providers included with this resource for popular resources such as ESX, QBOX and ox_lib. These can be found in the [`providers`](./providers/) folder of this repository. If you need any other providers you are welcome to create an issue, but before you do please ask the creator of the script if they can add support themselves as this makes it a lot easier for everyone.

You can also define your own "service", and use it across your own resources. Just register it under a non-taken service key, preferably something that will never be taken i.e. including your username, and you can retrieve it in your resources.

## Installation
After downloading, add the `r3_servicesmanager` folder from the zip file to the resources folder of your server. Then add the following to your `server.cfg`:

```cfg
start r3_servicesmanager
```

Make sure to place this before any scripts that make use of the services manager. It is recommended to start it as one of the first scripts in your startup, as it will register the included providers as soon as their resources start. Ideally, any resource that registers providers within the services manager should start before all the resources that retrieve providers.

## How to use this?
Well it's really simple actually. Let me guide you through it.

### Registering a service provider
You can register a service provider using the `register` export:

```lua
exports.r3_servicesmanager:register(service, provider, priority, resource)
```

This will register your provider for the given service with a given priority.

Parameters:
- service: `string` The service to register.
- provider: `table` A table of functions implementing the defined interface for the service.
- priority: [`ServicePriority`](#servicepriority) The priority of the provider, it is recommended to use priority `2` and make it configurable for server owners.
- resource: `string` The resource this provider provides the service for. The provider will be unregistered automatically if this resource stops. Usually you should put `GetCurrentResourceName()` here.

Returns:
- `nil`

### Loading a service provider
You can retrieve a service provider using the `load` export:

```lua
local serviceProvider = exports.r3_servicesmanager:load(service)
```

This loads the provider directly if one is registered.

Parameters:
- service: `string` The service to load the provider for.

Returns:
- `table` The currently registered provider for the service with the highest priority.
- `nil` If there is no provider registered for the service.

### Retrieving a registration
If you need more information about a provider, you can retrieve the RegisteredProvider completely using the `getRegistration` export:

```lua
local registeredProvider = exports.r3_servicesmanager:getRegistration(service)
```

This way you can check which provider is currently active, and check for which resource it is and what priority it has for instance.

Parameters:
- service: `string` The service to get the registration for.

Returns:
- [`RegisteredProvider`](#registeredprovider) The full registration of the currently registered provider for the service with the highest priority.
- `nil` If there is no provider registered for the service.

### Retrieving all registrations for a service
You can also retrieve all registrations for a specific service using the `getRegistrationsForService` export:

```lua
local registeredProviders = exports.r3_servicesmanager:getRegistrationsForService(service)
```

Parameters:
- service: `string` The service to get the registrations for.

Returns:
- `RegisteredProvider[]` A list of registered providers for the service.

### Retrieving all registrations for a resource
You can also retrieve all registrations for a specific resource using the `getRegistrationsForResource` export:

```lua
local registeredProviders = exports.r3_servicesmanager:getRegistrationsForResource(resource)
```

Parameters:
- resource: `string` The resource to get the registrations for.

Returns:
- `RegisteredProvider[]` A list of registered providers for the resource.

### Getting all known services
To retrieve all known services you can use the `getKnownServices` export:

```lua
local knownServices = exports.r3_servicesmanager:getKnownServices()
```

Returns:
- `string[]` A list of services that are known by the services manager, meaning they have a provider registered currently or had at least one before.

### Checking if there is a provider for a service
To check if there is currently a provider registered for a service you can use the `isProvidedFor` export:

```lua
exports.r3_servicesmanager:isProvidedFor(service)
```

Parameters:
- service: `string` The service to check if there is a provider registered for it.

## Events
Events are triggered when a provider gets registered or unregistered. The following events get triggered:

- `r3_servicesmanager:providerRegistered`
- `r3_servicesmanager:providerUnregistered`

Both events provide the [RegisteredProvider](#registeredprovider) in question as an argument.

## Types
The following types are used with the provided exports:

### ServicePriority
The priority of a service provider.

Fields:
- Lowest: 0
- Low: 1
- Normal: 2
- High: 3
- Highest: 4

### RegisteredProvider
A registration of a provider for a service.

Methods:
- getService(): `string` The service the provider provides.
- getProvider(): `table` The provider object.
- getPriority(): [`ServicePriority`](#servicepriority) The priority of the provider.
- getResource(): `string` The resource the provider was registered for.
- getInvokingResource(): `string` The resource that registered the provider.
