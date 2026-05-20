local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent("qb-repair:chargePlayer", function(amount)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player then
        if Player.Functions.RemoveMoney("cash", amount, "vehicle-repair") then
            TriggerClientEvent("QBCore:Notify", src, "Seu veículo foi reparado por $" .. amount, "success")
        else
            TriggerClientEvent("QBCore:Notify", src, "Dinheiro insuficiente!", "error")
        end
    end
end)
