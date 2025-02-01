# Employment
The employment providers provide a service that allows resources to interact with players their jobs.

## Usage
To retrieve the employment provider, use the load function with `"employment"` for the `service` parameter.

Lua:
```lua
local employment = exports.r3_servicesmanager:load("employment")
```

JavaScript:
```js
const employment = exports.r3_servicesmanager.load("employment");
```

### Server
On the server side, the following methods are available:

#### getJob
Retrieves a job object based on the name of the job.

```lua
employment.getJob(jobName)
```

Parameters:
- jobName: `string`

Returns:
- [`Job`](#job)

#### jobExists
Checks whether or not a job exists, optionally with a certain grade.

```lua
employment.jobExists(jobName, jobGrade)
```

Parameters:
- jobName: `string`
- jobGrade: `integer`

Returns:
- `boolean`

#### getOnlineJobCount
Returns the number of players currently online that have the specified job (and are on duty, if the provider supports it).

```lua
employment.getOnlineJobCount(jobName)
```

Parameters:
- jobName: `string`

Returns:
- `integer`

#### getPlayerJob
Returns the job of a player, or nil if the player is not online.

```lua
employment.getPlayerJob(playerId)
```

Parameters:
- playerId: `integer`

Returns:
- [`PlayerJob`](#playerjob)
- `nil` if the player could not be found.

#### setPlayerJob
Sets the player job to the specified job name and grade, and returns whether or not it was succesful.

```lua
employment.setPlayerJob(playerId, jobName, jobGrade)
```

Parameters:
- playerId: `integer`
- jobName: `string`
- jobGrade: `integer`

Returns:
- `true` if the job was successfully set.
- `false` if the job wasn't successfully set (i.e. it did not exist or the player could not be found).

#### playerHasJob
Checks whether a player has a certain job, and optionally checks if their grade is bigger or equal to the specified grade.

```lua
employment.playerHasJob(playerId, jobName, jobGrade)
```

Parameters:
- playerId: `integer`
- jobName: `string`
- jobGrade: `integer` (optional)

Returns:
- `true` if the player has the job and their grade satisfies the specified grade.
- `false` if the player does not have the job and grade, or if the player could not be found.

## Types
The following types are used within the employment provider:

### Job
An object containing the data of a job.

Fields:
- name: `string`
- label: `string`
- grades: [`table<integer, JobGrade>`](#jobgrade)

### PlayerJob
An object containing the job data of a player.

Fields:
- name: `string`
- label: `string`
- grade: `{ rank: integer }` & [`JobGrade`](#jobgrade)

### JobGrade
An object containing a job grade.

Fields:
- name: `string`
- label: `string`
- salary: `integer`
- isBoss: `boolean`

## Registration
To register an employment provider, ensure it implements all methods described above. Check out [`employment.lua`](./definitions/employment.lua) and [`employment.ts`](./definitions/employment.ts) for type definitions.

When your provider object implements all methods, you can register it as follows:

Lua:
```lua
exports.r3_servicesmanager:register("employment", provider, priority, GetCurrentResourceName())
```

JavaScript:
```js
exports.r3_servicesmanager.register("employment", provider, priority, GetCurrentResourceName());
```

For priority, it is recommended to use priority `2`, this corresponds to `ServicePriority.Normal`. It would be even better to allow server owners to configure the used priority in the configuration of your resource so that they can choose which resource takes priority.
