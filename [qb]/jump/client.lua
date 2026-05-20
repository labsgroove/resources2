local jumping = false
local spawnedPeds = {}
local lastPed = nil

-- Coordenadas da rampa
local spawnCoords = vector4(431.4380, 5708.4302, 714.0114, 44.6956)
local forwardVector = 15.0 -- Distância pra frente

-- Função para spawnar o NPC com veículo
local function spawnJumpingNPC()
    local models = { "player_one", "player_two" }
    local vehicles = { "wildtrak", "amarok" }

    local pedModel = models[math.random(#models)]
    local vehModel = vehicles[math.random(#vehicles)]

    RequestModel(pedModel)
    while not HasModelLoaded(pedModel) do Wait(0) end

    RequestModel(vehModel)
    while not HasModelLoaded(vehModel) do Wait(0) end

    local vehicle = CreateVehicle(vehModel, spawnCoords.xyz, spawnCoords.w, true, false)
    local ped = CreatePedInsideVehicle(vehicle, 4, pedModel, -1, true, false)
    TaskVehicleDriveToCoord(ped, vehicle, spawnCoords.xyz + GetEntityForwardVector(vehicle) * forwardVector, 80.0, 0, vehModel, 786603, 1.0, true)

    SetEntityAsMissionEntity(ped, true, true)
    table.insert(spawnedPeds, ped)
    lastPed = ped

    SetModelAsNoLongerNeeded(pedModel)
    SetModelAsNoLongerNeeded(vehModel)
end

-- Câmera espectador
local function setSpectateCamOnPed(ped)
    local cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", true)
    -- Offset típico de terceira pessoa (atrás e acima)
    local offset = vector3(0.0, -9.0, 2.5)
    AttachCamToEntity(cam, ped, offset.x, offset.y, offset.z, true)
    SetCamActive(cam, true)
    RenderScriptCams(true, true, 1000, true, true)

    -- Thread para atualizar a rotação da câmera conforme o ped se move
    CreateThread(function()
        while jumping and DoesEntityExist(ped) do
            local heading = GetEntityHeading(ped)
            SetCamRot(cam, 0.0, 0.0, heading, 2)
            Wait(0)
        end
    end)
end

-- 3D Text
local function Draw3DText(x, y, z, text)
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    DrawText(_x,_y)
end

CreateThread(function()
    while true do
        Wait(0)
        local coords = GetEntityCoords(PlayerPedId())
        local dist = #(coords - spawnCoords.xyz)
        if dist < 10.0 then
            Draw3DText(430.1230, 5702.0806, 715.8965, "[E] para JUMP | ESC para sair")
            if IsControlJustPressed(0, 38) then -- E
                jumping = true
                spawnJumpingNPC()
                setSpectateCamOnPed(lastPed)
                CreateThread(function()
                    while jumping do
                        Wait(15000)
                        spawnJumpingNPC()
                        setSpectateCamOnPed(lastPed)
                    end
                end)
            elseif IsControlJustPressed(0, 322) then -- ESC
                jumping = false
                RenderScriptCams(false, false, 0, true, true)
                DestroyAllCams(true)
            end
        end
    end
end)
