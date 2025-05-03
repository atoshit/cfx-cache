# cfx-cache

Quite simple cache system with automatically send events to the client when using the methods to be able to synchronize data between the client and the server.

# Use
## Create
```lua
  Cache:create('ranks')
```

## Set
```lua
  -- One
    Cache:set('ranks', 'test', {
        name = 'test',
        description = 'test',
    })

  -- Multiple
    Cache:set('ranks', {
        admin = { name = 'Admin', permissions = {'all'} },
        moderator = { name = 'Modérateur', permissions = {'kick', 'ban'} },
        helper = { name = 'Helper', permissions = {'warn'} }
    })
```

## Get
```lua
    Cache:get('ranks')
```
