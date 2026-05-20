local QBCore = exports['qb-core']:GetCoreObject()

TacoTruckRob = {['lastHeist'] = 0}

QBCore.Functions.CreateCallback('pp-cayo:server:checkTime', function(source, cb)
    local src = source
    local player = QBCore.Functions.GetPlayer(src)
    
    if (os.time() - TacoTruckRob['lastHeist']) < Config['Rob']['Timenextrob'] and TacoTruckRob['lastHeist'] ~= 0 then
        local seconds = Config['Rob']['Timenextrob'] - (os.time() - TacoTruckRob['lastHeist'])
        TriggerClientEvent('QBCore:Notify', src, 'Nada por enquanto, aguarde ' .. ' ' .. math.floor(seconds / 60) .. ' ' .. 'minutos')
        cb(false)
    else
        TacoTruckRob['lastHeist'] = os.time()
        cb(true)
    end
end)

RegisterServerEvent('pp-cayo:server:rewardItem')
AddEventHandler('pp-cayo:server:rewardItem', function(sellprice , item, itemamount)
    local src = source
    local player = QBCore.Functions.GetPlayer(src)

    if player then
        player.Functions.AddItem(item, itemamount)
        player.Functions.AddMoney('cash', sellprice)    
    end
end)

RegisterNetEvent('pp-cayo:server:policeAlert')
AddEventHandler('pp-cayo:server:policeAlert', function(coords)
    local players = QBCore.Functions.GetPlayers()
    for i = 1, #players do
        local player = QBCore.Functions.GetPlayer(players[i])
        if player.PlayerData.job.name == Config['Rob']['Policejobname'] then
            TriggerClientEvent('pp-cayo:client:policeAlert', players[i], coords)
        end
    end
end)