local QBCore = exports['qb-core']:GetCoreObject()

-- Configuração dos locais e veículos
local locations = {
    {coords = vector3(-162.9613, -2130.4546, 16.7050), vehicleSpawn = vector4(-162.2670, -2134.3765, 16.7050, 290.1205), model = 'm3e36', taken = false},
    {coords = vector3(171.8710, -1007.2323, 29.3372), vehicleSpawn = vector4(174.1581, -1011.6391, 29.2866, 204.3861), model = 'chr20', taken = false},
    {coords = vector3(1434.0880, -1497.4363, 63.2236), vehicleSpawn = vector4(1434.0880, -1497.4363, 63.2236, 164.8404), model = 'fgt', taken = false},
    {coords = vector3(-1541.4669, -1269.5713, 1.4579), vehicleSpawn = vector4(-1548.1857, -1274.3085, 0.4031, 130.1489), model = 'toro', taken = false},
    {coords = vector3(-1395.3557, -3266.6880, 13.9398), vehicleSpawn = vector4(-1382.9608, -3248.2390, 13.9448, 329.1506), model = 'raiju', taken = false},
    {coords = vector3(1770.1881, 3239.8027, 42.1235), vehicleSpawn = vector4(1770.1881, 3239.8027, 42.1235, 101.9670), model = 'akula', taken = false},
    {coords = vector3(-724.8165, -1444.3826, 5.0005), vehicleSpawn = vector4(-724.8165, -1444.3826, 5.0005, 318.2549), model = 'buzzer', taken = false},
    {coords = vector3(-2251.2727, 3248.8298, 32.8102), vehicleSpawn = vector4(-2251.2727, 3248.8298, 32.8102, 238.6949), model = 'rogue', taken = false},
    {coords = vector3(-1597.5760, -1014.2686, 13.0215), vehicleSpawn = vector4(-1593.3135, -1013.2458, 13.0199, 259.1684), model = 'lp700r', taken = false}
}

-- Criar os blips no mapa
CreateThread(function()
    for _, loc in ipairs(locations) do
        local blip = AddBlipForCoord(loc.coords.x, loc.coords.y, loc.coords.z)
        SetBlipSprite(blip, 488) -- Ícone do blip
        SetBlipDisplay(blip, 4)
        SetBlipScale(blip, 0.8)
        SetBlipColour(blip, 24) -- Cor do blip
        SetBlipAsShortRange(blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString("Turismo")
        EndTextCommandSetBlipName(blip)
    end
end)

-- Criar o 3D text e interação
CreateThread(function()
    while true do
        local playerPed = PlayerPedId()
        local playerCoords = GetEntityCoords(playerPed)
        
        for _, loc in ipairs(locations) do
            local dist = #(playerCoords - loc.coords)
            
            if dist < 5.0 then
                if not loc.taken then
                    DrawText3D(loc.coords.x, loc.coords.y, loc.coords.z, "[E] Para pegar um veículo")
                    if IsControlJustReleased(0, 38) then -- Tecla E
                        loc.taken = true
                        SpawnVehicle(loc.vehicleSpawn, loc.model, loc)
                    end
                else
                    DrawText3D(loc.coords.x, loc.coords.y, loc.coords.z, "Veículo já retirado")
                end
            end
        end
        Wait(0)
    end
end)

-- Função para desenhar o texto 3D
function DrawText3D(x, y, z, text)
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    local scale = 0.35
    
    if onScreen then
        SetTextScale(scale, scale)
        SetTextFont(4)
        SetTextProportional(1)
        SetTextColour(255, 255, 255, 215)
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        AddTextComponentString(text)
        DrawText(_x, _y)
    end
end

-- Função para spawnar o veículo
function SpawnVehicle(spawnLocation, vehicleModel, loc)
    QBCore.Functions.SpawnVehicle(vehicleModel, function(vehicle)
        SetEntityCoords(vehicle, spawnLocation.x, spawnLocation.y, spawnLocation.z, false, false, false, true)
        SetEntityHeading(vehicle, spawnLocation.w)
        TaskWarpPedIntoVehicle(PlayerPedId(), vehicle, -1) -- Warp para o assento do motorista
        TriggerEvent("vehiclekeys:client:SetOwner", GetVehicleNumberPlateText(vehicle)) -- Dar chave ao jogador
    end, spawnLocation, true)
end
