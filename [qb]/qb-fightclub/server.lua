local QBCore = exports['qb-core']:GetCoreObject()
local running = false

-- Inicia o loop
RegisterNetEvent('fightclub:start', function()
    if running then return end
    running = true
    print('[FightClub] Arena iniciada.')
    TriggerClientEvent('fightclub:startRound', -1)
end)

-- Quando um client reporta o fim da luta
RegisterNetEvent('fightclub:endRound', function(winner)
    print('[FightClub] Round encerrado, vencedor: ' .. tostring(winner))
    TriggerClientEvent('fightclub:announceWinner', -1, winner)
    Wait(5000)
    TriggerClientEvent('fightclub:startRound', -1)
end)
