# cfx-cache

Quite simple cache system with send event automatically to the client when using the set method to be able to synchronize data between the client and the server.

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
