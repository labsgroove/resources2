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
    local model = GetHashKey("Santaclaus")
    local weapon = GetHashKey("weapon_raycarbine")

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

-- Lista de modelos usados pelo qb-zombies (usados para identificar zumbis)
local zombieModelNames = {
    "u_m_y_zombie_01",
    "g_f_m_undeadmage",
    "g_m_m_zombie_04",
    "ig_skeleton_01",
    "u_m_o_filmnoir",
}

local zombieModelHashes = {}
for _, name in ipairs(zombieModelNames) do
    zombieModelHashes[GetHashKey(name)] = true
end

-- Retorna uma lista de netIds de peds que parecem ser zumbis (por modelo ou grupo de relacionamento)
local function findNearbyZombies(radius)
    local zombies = {}
    local handle, ped = FindFirstPed()
    local success = true
    repeat
        if success and DoesEntityExist(ped) and not IsPedAPlayer(ped) then
            if not IsPedDeadOrDying(ped, true) then
                local px, py, pz = table.unpack(GetEntityCoords(ped, true))
                local sx, sy, sz = table.unpack(GetEntityCoords(shooterNpc or PlayerPedId(), true))
                local dist = Vdist(px, py, pz, sx, sy, sz)
                if dist <= radius then
                    local model = GetEntityModel(ped)
                    local rel = GetPedRelationshipGroupHash(ped)
                    if zombieModelHashes[model] or rel == GetHashKey("zombie") then
                        -- garantir que a entidade está networked antes de obter netId
                        if not NetworkGetEntityIsNetworked(ped) then
                            NetworkRegisterEntityAsNetworked(ped)
                        end
                        table.insert(zombies, NetworkGetNetworkIdFromEntity(ped))
                    end
                end
            end
        end
        success, ped = FindNextPed(handle)
    until not success
    EndFindPed(handle)
    return zombies
end

-- Função interna para tratar alvos (compartilhada entre evento net e busca local)
local function handleTargets(targetNetIds)
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
end

function startHuntLoop()
    Citizen.CreateThread(function()
        while DoesEntityExist(shooterNpc) and not IsPedDeadOrDying(shooterNpc, true) do
            -- Busca localmente zumbis próximos e atualiza o atirador
            local targets = findNearbyZombies(200.0) -- alcance de busca (ajustável)
            if #targets > 0 then
                handleTargets(targets)
            else
                -- se não encontrou localmente, limpa tasks
                ClearPedTasks(shooterNpc)
            end
            Wait(1500) -- A cada 1.5s, pega novos alvos
        end
    end)
end

RegisterNetEvent("boom:updateTargets", function(targetNetIds)
    -- reutiliza a função de tratamento de alvos (permite chamadas locais ou via servidor)
    handleTargets(targetNetIds)
end)
