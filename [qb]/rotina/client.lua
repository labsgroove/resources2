local QBCore = exports['qb-core']:GetCoreObject()

local routineActive = false
local playerPed = nil
local vehicle = nil

local routinePoints = {
    { coords = vector3(-48.92, -1758.68, 29.42), action = "comprar_comida", desc = "mercado" },
    { coords = vector3(1153.25, -326.67, 69.21), action = "abastecer", desc = "posto" },
    { coords = vector3(-1193.92, -769.79, 17.32), action = "olhar_vitrine", desc = "loja de roupas" },
    { coords = vector3(-814.08, -183.79, 37.57), action = "tomar_cafe", desc = "cafeteria" },
}

local function getRandomPoint()
    return routinePoints[math.random(1, #routinePoints)]
end

local function doAction(action)
    if action == "comprar_comida" then
        TaskStartScenarioInPlace(playerPed, "WORLD_HUMAN_SMOKING", 0, true)
        QBCore.Functions.Notify("Pegando um lanche no mercado...", "success")
        Wait(5000)
    elseif action == "abastecer" then
        TaskStartScenarioInPlace(playerPed, "WORLD_HUMAN_CAR_PARK_ATTENDANT", 0, true)
        QBCore.Functions.Notify("Abastecendo o carro...", "primary")
        Wait(7000)
    elseif action == "olhar_vitrine" then
        TaskStartScenarioInPlace(playerPed, "WORLD_HUMAN_WINDOW_SHOP_BROWSE", 0, true)
        QBCore.Functions.Notify("Observando as roupas...", "info")
        Wait(6000)
    elseif action == "tomar_cafe" then
        TaskStartScenarioInPlace(playerPed, "WORLD_HUMAN_DRINKING", 0, true)
        QBCore.Functions.Notify("Tomando um café...", "success")
        Wait(4000)
    end
    ClearPedTasks(playerPed)
end

local function startRoutine()
    playerPed = PlayerPedId()
    QBCore.Functions.Notify("Rotina automática iniciada.", "success")

    CreateThread(function()
        while routineActive do
            local point = getRandomPoint()
            local coords = point.coords

            if not IsPedInAnyVehicle(playerPed, false) then
                local veh = GetClosestVehicle(GetEntityCoords(playerPed), 10.0, 0, 70)
                if veh ~= 0 then
                    TaskEnterVehicle(playerPed, veh, -1, -1, 2.0, 1, 0)
                    Wait(3000)
                    vehicle = veh
                end
            end

            -- Define estilo e velocidade
local driveSpeed = math.random(15, 25) -- velocidade aleatória pra variar o comportamento
local driveStyle = 786603 -- estilo padrão (normal + evita colisões)

-- Configura comportamento de direção
SetDriveTaskDrivingStyle(playerPed, driveStyle)
SetDriveTaskCruiseSpeed(playerPed, driveSpeed)

-- Usa o caminho da IA pra dirigir naturalmente
TaskVehicleDriveToCoordLongrange(playerPed, vehicle, coords.x, coords.y, coords.z, driveSpeed, driveStyle, 5.0)
QBCore.Functions.Notify("Indo até o " .. point.desc .. "...", "primary")


            while #(GetEntityCoords(playerPed) - coords) > 10.0 and routineActive do
                Wait(1000)
            end

            TaskLeaveVehicle(playerPed, vehicle, 0)
            Wait(2000)
            doAction(point.action)

            Wait(math.random(4000, 8000))
        end
    end)
end

RegisterCommand("rotina", function()
    routineActive = not routineActive

    if routineActive then
        startRoutine()
    else
        QBCore.Functions.Notify("Rotina automática encerrada.", "error")
        ClearPedTasksImmediately(PlayerPedId())
    end
end)
