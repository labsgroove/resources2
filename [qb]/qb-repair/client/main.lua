local QBCore = exports['qb-core']:GetCoreObject()

-- Configuração dos locais de reparo
local repairStations = {
    {x = -211.55, y = -1324.55, z = 30.89}, -- Ponto de reparo 1
    {x = 1175.92, y = 2640.64, z = 37.75}, -- Ponto de reparo 2
    {x = 2005.19, y = 3774.07, z = 32.40}  -- Ponto de reparo 3
}

local repairCost = 420

-- Criando os blips no mapa
CreateThread(function()
    for _, station in pairs(repairStations) do
        local blip = AddBlipForCoord(station.x, station.y, station.z)
        SetBlipSprite(blip, 402) -- Ícone de mecânico
        SetBlipDisplay(blip, 4)
        SetBlipScale(blip, 0.8)
        SetBlipColour(blip, 5)
        SetBlipAsShortRange(blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString("Ponto de Reparo")
        EndTextCommandSetBlipName(blip)
    end
end)

-- Criando o 3D Text e a interação
CreateThread(function()
    while true do
        local player = PlayerPedId()
        local playerCoords = GetEntityCoords(player)
        local inVehicle = IsPedInAnyVehicle(player, false)
        local sleep = 1000

        for _, station in pairs(repairStations) do
            local dist = #(playerCoords - vector3(station.x, station.y, station.z))
            if dist < 5.0 then
                sleep = 0
                DrawText3D(station.x, station.y, station.z + 1.0, "Pressione ~g~E~w~ para reparar o veículo ($420)")
                if IsControlJustReleased(0, 38) and inVehicle then -- Tecla 'E'
                    RepairVehicle()
                end
            end
        end
        Wait(sleep)
    end
end)

-- Função para reparar o veículo
function RepairVehicle()
    local player = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(player, false)
    local playerData = QBCore.Functions.GetPlayerData()
    local cash = playerData.money["cash"]

    if cash >= repairCost then
        QBCore.Functions.Notify("Reparando veículo...", "success", 3000)
        Wait(5000)
        SetVehicleFixed(vehicle)
        SetVehicleDirtLevel(vehicle, 0.0)
        TriggerServerEvent("qb-repair:chargePlayer", repairCost)
        QBCore.Functions.Notify("Seu veículo foi reparado por $420", "success", 3000)
    else
        QBCore.Functions.Notify("Dinheiro insuficiente!", "error", 3000)
    end
end

-- Função para desenhar texto 3D
function DrawText3D(x, y, z, text)
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x, y, z, 0)
    DrawText(0.0, 0.0)
    ClearDrawOrigin()
end

-- Evento do servidor para cobrar o jogador
RegisterNetEvent("qb-repair:chargePlayer")
AddEventHandler("qb-repair:chargePlayer", function(amount)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player then
        Player.Functions.RemoveMoney("cash", amount, "vehicle-repair")
    end
end)
