RegisterCommand("party", function(source, args, rawCommand)
    -- Pegando o jogador que executou o comando
    local playerPed = GetPlayerPed(source)
    local playerCoords = GetEntityCoords(playerPed)

    -- Enviar evento para todos os jogadores
    TriggerClientEvent("spawnPartyNPCs", -1, playerCoords)
end, false)