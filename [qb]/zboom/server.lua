RegisterNetEvent("boom:getNearbyTargets", function()
    local src = source
    local player = GetPlayerPed(src)
    local coords = GetEntityCoords(player)

    TriggerClientEvent("boom:spawnShooter", src)
end)

RegisterNetEvent("boom:getNearbyTargetsLoop", function()
    local src = source
    local player = GetPlayerPed(src)
    if not DoesEntityExist(player) then return end
    local coords = GetEntityCoords(player)

    local targets = {}

    -- Alvos: motoristas de veículos
    for _, veh in ipairs(GetAllVehicles()) do
        if #(GetEntityCoords(veh) - coords) < 100.0 then
            local driver = GetPedInVehicleSeat(veh, -1)
            if driver ~= 0 and not IsPedAPlayer(driver) then
                table.insert(targets, NetworkGetNetworkIdFromEntity(driver))
            end
        end
    end

    TriggerClientEvent("boom:updateTargets", src, targets)
end)
