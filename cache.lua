---@class Cache
---@field create fun(name: string): table
---@field set fun(cacheName: string, key: any, value: any): boolean
---@field get fun(cacheName: string, key: any): any
---@field delete fun(cacheName: string, key: any): boolean
---@field clear fun(cacheName: string): boolean
---@field exists fun(cacheName: string): boolean
local Cache = {}

local caches = {}

---@param name string The name of the cache to create
---@return table The created cache
function Cache:create(name)
    if caches[name] then
        return caches[name]
    end
    
    local cache = {}
    
    setmetatable(cache, {})
    
    caches[name] = cache
    return cache
end

---@param cacheName string The name of the cache
---@param key any The key to use or a table of key-value pairs
---@param value any|nil The value to store (ignored if key is a table)
---@return boolean Success of the operation
function Cache:set(cacheName, key, value)
    local cache = caches[cacheName]
    if not cache then
        return false
    end
    
    if type(key) == 'table' and value == nil then
        local updatedValues = {}
        for k, v in pairs(key) do
            rawset(cache, k, v)
            updatedValues[k] = v
        end
        TriggerClientEvent('cache:' .. cacheName .. ':updateBulk', -1, updatedValues)
        return true
    else
        rawset(cache, key, value)
        TriggerClientEvent('cache:' .. cacheName .. ':update', -1, key, value)
        return true
    end
end

---@param cacheName string The name of the cache
---@param key any|nil The key to search for (optional)
---@return any The value associated with the key, the entire cache if no key, or nil if not found
function Cache:get(cacheName, key)
    local cache = caches[cacheName]
    if not cache then
        return nil
    end
    
    if key == nil then
        return cache
    end
    
    return cache[key]
end

---@param cacheName string The name of the cache
---@param key any The key to delete
---@return boolean Success of the operation
function Cache:delete(cacheName, key)
    local cache = caches[cacheName]
    if not cache then
        return false
    end
    
    if cache[key] ~= nil then
        cache[key] = nil
        TriggerClientEvent('cache:' .. cacheName .. ':delete', -1, key)
        return true
    end
    
    return false
end

---@param cacheName string The name of the cache to clear
---@return boolean Success of the operation
function Cache:clear(cacheName)
    if not caches[cacheName] then
        return false
    end
    
    caches[cacheName] = {}
    setmetatable(caches[cacheName], getmetatable(caches[cacheName]))
    TriggerClientEvent('cache:' .. cacheName .. ':clear', -1)
    return true
end

---@param cacheName string The name of the cache to check
---@return boolean True if the cache exists, false otherwise
function Cache:exists(cacheName)
    return caches[cacheName] ~= nil
end
