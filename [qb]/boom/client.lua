local shooterNpc = nil
local boomCam = nil -- câmera do atirador

RegisterCommand("boom", function()
    TriggerServerEvent("boom:getNearbyTargets")
end)

-- Comando para ativar a câmera espectador no atirador
RegisterCommand('boomcam', function()
    if shooterNpc and DoesEntityExist(shooterNpc) then
        if boomCam and DoesCamExist(boomCam) then
            print('Câmera já está ativa no atirador!')
            return
        end
        local sx, sy, sz = table.unpack(GetEntityCoords(shooterNpc, true))
        boomCam = CreateCam('DEFAULT_SCRIPTED_CAMERA', true)
        SetCamCoord(boomCam, sx, sy, sz + 2.0)
        PointCamAtEntity(boomCam, shooterNpc, 0.0, 0.0, 1.0, true)
        AttachCamToEntity(boomCam, shooterNpc, 0.0, -3.0, 2.0, true)
        SetCamActive(boomCam, true)
        RenderScriptCams(true, false, 0, true, true)
        print('Modo espectador ativado no atirador!')
    else
        print('Nenhum atirador ativo para focar!')
    end
end, false)

-- Comando para desativar a câmera espectador
RegisterCommand('boomcamoff', function()
    if boomCam and DoesCamExist(boomCam) then
        RenderScriptCams(false, false, 0, true, true)
        DestroyCam(boomCam, false)
        boomCam = nil
        print('Modo espectador desativado!')
    else
        print('Câmera do atirador não está ativa!')
    end
end, false)

RegisterNetEvent("boom:spawnShooter", function(targetNetIds)
    local playerPed = PlayerPedId()
    local coords = GetEntityCoords(playerPed)
    local model = GetHashKey("bender")
    local weapon = GetHashKey("weapon_raypistol")

    RequestModel(model)
    while not HasModelLoaded(model) do Wait(10) end

    local spawnPos = GetOffsetFromEntityInWorldCoords(playerPed, 2.0, 0.0, 0.0)
    shooterNpc = CreatePed(4, model, spawnPos.x, spawnPos.y, spawnPos.z, 0.0, true, true)
    GiveWeaponToPed(shooterNpc, weapon, 999, false, true)
    SetPedCombatAttributes(shooterNpc, 46, true)
    SetPedAsEnemy(shooterNpc, true)
    SetPedAccuracy(shooterNpc, 100)
    SetPedDropsWeaponsWhenDead(shooterNpc, false)
    SetPedFleeAttributes(shooterNpc, 0, 0)
    SetEntityInvincible(shooterNpc, true)
    SetPedCanRagdoll(shooterNpc, false)

    startHuntLoop()
end)

function startHuntLoop()
    Citizen.CreateThread(function()
        while DoesEntityExist(shooterNpc) and not IsPedDeadOrDying(shooterNpc, true) do
            -- Pede novos alvos ao servidor
            TriggerServerEvent("boom:getNearbyTargetsLoop")
            Wait(1500) -- A cada 5s, pega novos alvos
        end
    end)
end

RegisterNetEvent("boom:updateTargets", function(targetNetIds)
    if not DoesEntityExist(shooterNpc) then return end

    local shooterCoords = GetEntityCoords(shooterNpc)
    local closestTarget = nil
    local closestDist = math.huge

    for _, netId in ipairs(targetNetIds) do
        local target = NetToPed(netId)
        if DoesEntityExist(target) and not IsPedDeadOrDying(target, true) then
            local targetCoords = GetEntityCoords(target)
            local dist = #(shooterCoords - targetCoords)
            if dist < closestDist then
                closestDist = dist
                closestTarget = target
            end
        end
    end

    if closestTarget then
        -- Só troca de alvo se não estiver atirando nesse
        if not IsPedShooting(shooterNpc) or GetPedTargetFromAim(shooterNpc) ~= closestTarget then
            TaskShootAtEntity(shooterNpc, closestTarget, 1000, GetHashKey("FIRING_PATTERN_FULL_AUTO"))
        end
    else
        ClearPedTasks(shooterNpc)
    end
end)
