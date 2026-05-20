local revealDuration = 300000 -- Duration in milliseconds (e.g., 60000ms = 60 seconds)
local updateInterval = 1000 -- Interval to update the blip position in milliseconds (e.g., 1000ms = 1 second)

RegisterNetEvent('map-reveal:client:useCode', function()
    local playerPed = PlayerPedId()
    local playerCoords = GetEntityCoords(playerPed)
    local blip = AddBlipForCoord(playerCoords.x, playerCoords.y, playerCoords.z)

    SetBlipSprite(blip, 161) -- Set the blip icon
    SetBlipColour(blip, 51) -- Set the blip color
    SetBlipScale(blip, 1.0) -- Set the blip scale
    BeginTextCommandSetBlipName('STRING')
    AddTextComponentString('Revealed Player')
    EndTextCommandSetBlipName(blip)

    -- Notify all players about the revealed player
    TriggerServerEvent('map-reveal:server:notifyPlayers', GetPlayerServerId(PlayerId()))

    -- Update the blip position periodically
    Citizen.CreateThread(function()
        local endTime = GetGameTimer() + revealDuration
        while GetGameTimer() < endTime do
            playerCoords = GetEntityCoords(playerPed)
            SetBlipCoords(blip, playerCoords.x, playerCoords.y, playerCoords.z)
            Citizen.Wait(updateInterval)
        end
        RemoveBlip(blip)
    end)
end)

RegisterNetEvent('map-reveal:client:notifyPlayers', function(playerId)
    local blip = AddBlipForEntity(GetPlayerPed(GetPlayerFromServerId(playerId)))

    SetBlipSprite(blip, 161) -- Set the blip icon
    SetBlipColour(blip, 51) -- Set the blip color
    SetBlipScale(blip, 1.0) -- Set the blip scale
    BeginTextCommandSetBlipName('STRING')
    AddTextComponentString('Revealed Player')
    EndTextCommandSetBlipName(blip)

    -- Update the blip position periodically
    Citizen.CreateThread(function()
        local endTime = GetGameTimer() + revealDuration
        while GetGameTimer() < endTime do
            local playerPed = GetPlayerPed(GetPlayerFromServerId(playerId))
            local playerCoords = GetEntityCoords(playerPed)
            SetBlipCoords(blip, playerCoords.x, playerCoords.y, playerCoords.z)
            Citizen.Wait(updateInterval)
        end
        RemoveBlip(blip)
    end)
end)