local binser = require 'engine/external/binser'

local settings = {}

settings.file = 'settings.dat'
settings.binds = {}
settings.defaults = {}

function settings.setDefaultBinds(binds)
    settings.defaults = {}
    for action, keys in pairs(binds) do
        if type(keys) == 'table' then
            settings.defaults[action] = table.copy(keys)
        else
            settings.defaults[action] = {keys}
        end
    end
    if not settings.loaded then
        settings.binds = {}
        for action, keys in pairs(settings.defaults) do
            settings.binds[action] = table.copy(keys)
        end
    end
end

function settings.load()
    if love.filesystem.getInfo(settings.file) then
        local ok, data = pcall(function()
            local content = love.filesystem.read(settings.file)
            return binser.deserialize(content)
        end)
        if ok and type(data) == 'table' and data[1] and data[1].binds then
            settings.binds = data[1].binds
            settings.loaded = true
            for action, keys in pairs(settings.defaults) do
                if not settings.binds[action] then
                    settings.binds[action] = table.copy(keys)
                end
            end
            return
        end
    end
    settings.binds = {}
    for action, keys in pairs(settings.defaults) do
        settings.binds[action] = table.copy(keys)
    end
    settings.loaded = true
end

function settings.save()
    local data = {binds = settings.binds}
    local ok, serialized = pcall(binser.serialize, data)
    if ok then
        love.filesystem.write(settings.file, serialized)
    end
end

function settings.rebind(action, keys)
    if type(keys) == 'table' then
        settings.binds[action] = table.copy(keys)
    else
        settings.binds[action] = {keys}
    end
    settings.save()
end

function settings.reset(action)
    if settings.defaults[action] then
        settings.binds[action] = table.copy(settings.defaults[action])
        settings.save()
    end
end

function settings.resetAll()
    for action, keys in pairs(settings.defaults) do
        settings.binds[action] = table.copy(keys)
    end
    settings.save()
end

function settings.getBinds(action)
    return settings.binds[action] or settings.defaults[action] or {}
end

return settings
