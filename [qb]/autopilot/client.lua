local QBCore = nil
local autopilotEnabled = false
local autopilotThread = nil
local airPoints = {
    vector3(3832.7891, -4698.0796, 83.8054),
    vector3(-992.0467, -2965.9058, 129.5775),
    vector3(-91.5655, -826.3406, 362.9660),
    vector3(1220.4243, -194.7263, 198.2138),
    vector3(2880.7751, 2741.8462, 177.6153),
    vector3(1080.4705, 3059.4465, 166.4917),
    vector3(-2743.7795, 3225.9194, 183.1189),
    vector3(-535.8773, 5979.5303, 128.1973),
    vector3(1954.0696, 4726.8154, 122.7453),
    vector3(-1992.5649, -1055.7319, 61.9174),
}
local lastPointIndex = nil


CreateThread(function()
    while not QBCore do
        pcall(function()
            QBCore = exports['qb-core']:GetCoreObject()
        end)
        Wait(100)
    end

    RegisterCommand("autopilot", function()
        local ped = PlayerPedId()
        local vehicle = GetVehiclePedIsIn(ped, false)

        if not IsPedInAnyVehicle(ped, false) or not isAircraft(vehicle) then
            QBCore.Functions.Notify("Você precisa estar em uma aeronave para usar o autopilot.", "error")
            return
        end

        if autopilotEnabled then
            autopilotEnabled = false
            QBCore.Functions.Notify("Autopilot desativado.", "primary")
            if autopilotThread then
                TerminateThread(autopilotThread)
                autopilotThread = nil
            end
            ClearPedTasks(ped)
        else
            if GetPedInVehicleSeat(vehicle, -1) ~= ped then
                QBCore.Functions.Notify("Você precisa estar no assento do piloto.", "error")
                return
            end

            autopilotEnabled = true
            QBCore.Functions.Notify("Autopilot ativado. Rota aérea iniciada.", "success")
            startAutopilot(ped, vehicle)
        end
    end, false)
end)

function isAircraft(vehicle)
    local class = GetVehicleClass(vehicle)
    return class == 15 or class == 16 or class == 19
end

function getNextAirPoint()
    local options = {}
    for i = 1, #airPoints do
        if i ~= lastPointIndex then
            table.insert(options, i)
        end
    end
    local chosenIndex = options[math.random(1, #options)]
    lastPointIndex = chosenIndex
    return airPoints[chosenIndex]
end

function startAutopilot(ped, vehicle)
    if autopilotThread then
        TerminateThread(autopilotThread)
        autopilotThread = nil
    end

    autopilotThread = CreateThread(function()
        while autopilotEnabled do
            local nextDest = getNextAirPoint()

            -- Manda a IA voar suave até o ponto
            TaskVehicleDriveToCoord(
                ped, vehicle,
                nextDest.x, nextDest.y, nextDest.z,
                60.0, -- velocidade
                0, -- drivingStyle
                GetEntityModel(vehicle),
                262144, -- flag pra vôo
                10.0 -- parada próxima
            )

            local arrived = false
            while not arrived and autopilotEnabled do
                local pos = GetEntityCoords(vehicle)
                local dist = #(pos - nextDest)
                if dist < 200.0 then
                    arrived = true
                    Wait(3000)
                end
                Wait(500)
            end
        end

        ClearPedTasks(ped)
    end)
end

