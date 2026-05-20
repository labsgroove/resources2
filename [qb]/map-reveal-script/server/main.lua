RegisterNetEvent('map-reveal:server:notifyPlayers', function(playerId)
    TriggerClientEvent('map-reveal:client:notifyPlayers', -1, playerId)
end)