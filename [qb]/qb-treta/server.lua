local QBCore
local spawnedPeds = {
    gangA = {},
    gangB = {}
}

CreateThread(function()
    while QBCore == nil do
        TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)
        Wait(100)
    end

    print("[qb-treta] QBCore carregado com sucesso.")

    -- Agora sim é seguro usar QBCore!
    QBCore.Functions.CreateCallback('gangs:getGangData', function(_, cb)
        cb(spawnedPeds)
    end)

    RegisterNetEvent('gangs:pedSpawned', function(gang, netId)
        table.insert(spawnedPeds[gang], netId)
        TriggerClientEvent('gangs:syncGang', -1, gang, spawnedPeds[gang])
    end)

    RegisterNetEvent('gangs:pedDied', function(gang, netId)
        for i, ped in ipairs(spawnedPeds[gang]) do
            if ped == netId then
                table.remove(spawnedPeds[gang], i)
                break
            end
        end
        TriggerClientEvent('gangs:syncGang', -1, gang, spawnedPeds[gang])
    end)
end)
