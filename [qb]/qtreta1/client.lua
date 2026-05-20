local spawned = {
    gangA = {},
    gangB = {}
}

local function spawnPed(gangKey, config)
    local pedModel = config.pedModels[math.random(#config.pedModels)]
    local weapon = config.weapons[math.random(#config.weapons)]

    RequestModel(pedModel)
    while not HasModelLoaded(pedModel) do Wait(0) end

    local x = config.coords.x + math.random(-0,3)
    local y = config.coords.y + math.random(-0,3)
    local z = config.coords.z

    local ped = CreatePed(4, pedModel, x, y, z, 0.0, true, false)
    GiveWeaponToPed(ped, GetHashKey(weapon), 9999, false, true)
    SetPedAsEnemy(ped, true)
    SetPedAccuracy(ped, 70)
    SetPedArmour(ped, 50)
    SetPedCombatAttributes(ped, 46, true)
    SetPedCombatAttributes(ped, 0, true) -- Permitir combate
    SetPedCombatAbility(ped, 2)
    SetPedFleeAttributes(ped, 0, false)
    SetPedRelationshipGroupHash(ped, GetHashKey(gangKey))

    local netId = NetworkGetNetworkIdFromEntity(ped)
    TriggerServerEvent('gangs:pedSpawned', gangKey, netId)
    table.insert(spawned[gangKey], ped)

    CreateThread(function()
        while DoesEntityExist(ped) do
            if IsEntityDead(ped) then
                TriggerServerEvent('gangs:pedDied', gangKey, netId)
                -- Remove o ped morto da tabela local
                for i, p in ipairs(spawned[gangKey]) do
                    if p == ped then
                        table.remove(spawned[gangKey], i)
                        break
                    end
                end
                -- Remove o ped do jogo
                Wait(5000) -- Aguarda um tempo antes de remover
                DeleteEntity(ped)
                break
            end

            -- Detectar NPCs inimigos próximos e iniciar combate
            local pedCoords = GetEntityCoords(ped)
            local enemyGroup = gangKey == "gangA" and GetHashKey("gangB") or GetHashKey("gangA")
            local nearbyPeds = GetNearbyPeds(ped, 200.0) -- Função fictícia, veja abaixo

            for _, nearbyPed in ipairs(nearbyPeds) do
                if DoesEntityExist(nearbyPed) and not IsPedAPlayer(nearbyPed) then
                    if GetPedRelationshipGroupHash(nearbyPed) == enemyGroup then
                        local enemyCoords = GetEntityCoords(nearbyPed)
                        local distance = #(pedCoords - enemyCoords)
                        if distance <= 200.0 then -- Distância de detecção
                            TaskCombatPed(ped, nearbyPed, 0, 16) -- Inicia combate
                            break
                        end
                    end
                end
            end

            Wait(1000)
        end
    end)
end

-- Função fictícia para obter peds próximos (substitua por lógica apropriada)
function GetNearbyPeds(ped, radius)
    local peds = {}
    local handle, targetPed = FindFirstPed()
    local success
    repeat
        if DoesEntityExist(targetPed) and targetPed ~= ped then
            local distance = #(GetEntityCoords(ped) - GetEntityCoords(targetPed))
            if distance <= radius then
                table.insert(peds, targetPed)
            end
        end
        success, targetPed = FindNextPed(handle)
    until not success
    EndFindPed(handle)
    return peds
end

CreateThread(function()
    -- Espera tudo carregar
    Wait(1000)
    local gangA = GetHashKey("gangA")
    local gangB = GetHashKey("gangB")

    AddRelationshipGroup("gangA")
    AddRelationshipGroup("gangB")

    SetRelationshipBetweenGroups(5, gangA, gangB) -- odeiam
    SetRelationshipBetweenGroups(5, gangB, gangA)

    SetRelationshipBetweenGroups(0, gangA, gangA) -- amigos entre si
    SetRelationshipBetweenGroups(0, gangB, gangB)
end)

local function maintainGang(gangKey, config)
    CreateThread(function()
        while true do
            -- Garante que a quantidade de NPCs seja mantida
            if #spawned[gangKey] < config.count then
                local deficit = config.count - #spawned[gangKey]
                for i = 1, deficit do
                    spawnPed(gangKey, config)
                end
            end
            Wait(5000) -- tempo entre verificações
        end
    end)
end

CreateThread(function()
    Wait(2000) -- garantir que tudo carregou

    for gangKey, config in pairs(Config.Gangs) do
        maintainGang(gangKey, config)
    end
end)
