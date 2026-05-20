local QBCore = exports['qb-core']:GetCoreObject()
local sharedConfig = require 'config.shared'

---@return number
local function getModPrice(mod, level)
    if mod == 'cosmetic' or mod == 'colors' or mod == 18 then
        return sharedConfig.prices[mod] --[[@as number]]
    else
        return sharedConfig.prices[mod][level]
    end
end

---@param source number
---@param amount number
---@return boolean
---@param source number
---@param amount number
---@return boolean
local function removeMoney(source, amount)
    local player = QBCore.Functions.GetPlayer(source)
    if not player then return false end

    local cashBalance = player.Functions.GetMoney('cash')
    local bankBalance = player.Functions.GetMoney('bank')

    if cashBalance >= amount then
        player.Functions.RemoveMoney('cash', amount, locale('general.payReason'))
        TriggerClientEvent('QBCore:Notify', source, locale('notifications.success.paid', amount), 'success')
        return true
    elseif bankBalance >= amount then
        player.Functions.RemoveMoney('bank', amount, locale('general.payReason'))
        TriggerClientEvent('QBCore:Notify', source, locale('notifications.success.paid', amount), 'success')
        return true
    end

    return false
end

-- Won't charge money for mods if the player's job is in the list
QBCore.Functions.CreateCallback('qbx_customs:server:pay', function(source, cb, mod, level, zone)
    -- zone should be provided by the client when calling this callback
    for i, v in ipairs(sharedConfig.zones) do
        if i == zone and v.freeMods then
            local player = QBCore.Functions.GetPlayer(source)
            local playerJob = player and player.PlayerData and player.PlayerData.job and player.PlayerData.job.name
            for _, job in ipairs(v.freeMods) do
                if playerJob == job then
                    cb(true)
                    return
                end
            end
        end
    end

    cb(removeMoney(source, getModPrice(mod, level)))
end)

-- Won't charge money for repairs if the player's job is in the list
QBCore.Functions.CreateCallback('qbx_customs:server:repair', function(source, cb, bodyHealth, zone)
    -- zone should be provided by the client when calling this callback
    for i, v in ipairs(sharedConfig.zones) do
        if i == zone and v.freeRepair then
            local player = QBCore.Functions.GetPlayer(source)
            local playerJob = player and player.PlayerData and player.PlayerData.job and player.PlayerData.job.name
            for _, job in ipairs(v.freeRepair) do
                if playerJob == job then
                    cb(true)
                    return
                end
            end
        end
    end

    local price = math.ceil(1000 - bodyHealth)
    cb(removeMoney(source, price))
end)

-- Compatibility wrappers for ox_lib lib.callback usage from client
if lib and lib.callback and lib.callback.register then
    lib.callback.register('qbx_customs:server:pay', function(source, mod, level)
        local zone = lib.callback.await('qbx_customs:client:zone', source)

        for i, v in ipairs(sharedConfig.zones) do
            if i == zone and v.freeMods then
                local player = QBCore.Functions.GetPlayer(source)
                local playerJob = player and player.PlayerData and player.PlayerData.job and player.PlayerData.job.name
                for _, job in ipairs(v.freeMods) do
                    if playerJob == job then
                        return true
                    end
                end
            end
        end

        return removeMoney(source, getModPrice(mod, level))
    end)

    lib.callback.register('qbx_customs:server:repair', function(source, bodyHealth)
        local zone = lib.callback.await('qbx_customs:client:zone', source)

        for i, v in ipairs(sharedConfig.zones) do
            if i == zone and v.freeRepair then
                local player = QBCore.Functions.GetPlayer(source)
                local playerJob = player and player.PlayerData and player.PlayerData.job and player.PlayerData.job.name
                for _, job in ipairs(v.freeRepair) do
                    if playerJob == job then
                        return true
                    end
                end
            end
        end

        local price = math.ceil(1000 - bodyHealth)
        return removeMoney(source, price)
    end)
end

local function IsVehicleOwned(plate)
    local result = MySQL.scalar.await('SELECT 1 from player_vehicles WHERE plate = ?', {plate})
    if result then
        return true
    else
        return false
    end
end

--Copied from qb-mechanicjob
RegisterNetEvent('qbx_customs:server:saveVehicleProps')
AddEventHandler('qbx_customs:server:saveVehicleProps', function(vehicleProps)
    local src = source --[[@as number]]
    if not vehicleProps then return end
    if IsVehicleOwned(vehicleProps.plate) then
        MySQL.update.await('UPDATE player_vehicles SET mods = ? WHERE plate = ?', {json.encode(vehicleProps), vehicleProps.plate})
    end
end)
