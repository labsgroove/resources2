local QBCore = exports['qb-core']:GetCoreObject()

-- CONFIGURAÇÕES
local pos1 = vector3(787.4925, -241.8173, 66.1142)
local pos2 = vector3(754.8389, -224.8160, 66.1201)
local center = vector3(771.3582, -233.5494, 66.1145)

local npcModels = {
    "a_f_m_fatcult_01",
    "a_f_m_bodybuild_01",
    "a_f_m_fatwhite_01",
    "a_f_m_fatbla_01",
    "ig_maude",
    "a_f_o_salton_01",
    "a_f_o_indian_01",
    "a_f_y_soucent_01",
    "a_f_y_tourist_02",

}

local currentFighters = {}
local textDraw = nil
local showingText = false

-- Função para carregar modelos
local function loadModel(model)
    RequestModel(model)
    while not HasModelLoaded(model) do
        Wait(10)
    end
end

-- Cria NPC
local function spawnFighter(model, coords)
    loadModel(model)
    local ped = CreatePed(4, model, coords.x, coords.y, coords.z, 0.0, true, true)
    SetPedCombatAttributes(ped, 46, true)
    SetPedCombatAbility(ped, 100)
    SetPedCombatRange(ped, 2)
    SetPedFleeAttributes(ped, 0, false)
    SetPedArmour(ped, 100)
    SetEntityInvincible(ped, false)
    SetPedCanRagdoll(ped, true)
    SetPedAccuracy(ped, 60)
    return ped
end

-- 3D Texto no ring
local function DrawText3D(coords, text)
    local x, y, z = coords.x, coords.y, coords.z + 1.0
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    local dist = #(vector3(px,py,pz) - vector3(x,y,z))
    local scale = (1/dist)*2
    if onScreen then
        SetTextScale(0.0*scale, 0.9*scale)
        SetTextFont(4)
        SetTextProportional(1)
        SetTextColour(255, 215, 0, 255)
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x,_y)
    end
end

-- Rodada de luta
RegisterNetEvent('fightclub:startRound', function()
    if #currentFighters > 0 then
        for _, ped in ipairs(currentFighters) do
            if DoesEntityExist(ped) then DeleteEntity(ped) end
        end
        currentFighters = {}
    end

    local model1 = npcModels[math.random(#npcModels)]
    local model2 = npcModels[math.random(#npcModels)]

    local npc1 = spawnFighter(model1, pos1)
    local npc2 = spawnFighter(model2, pos2)

    TaskCombatPed(npc1, npc2, 0, 16)
    TaskCombatPed(npc2, npc1, 0, 16)

    currentFighters = {npc1, npc2}

    QBCore.Functions.Notify("Nova luta começou!", "primary", 3000)

    CreateThread(function()
        local winner
        while true do
            Wait(500)
            if not DoesEntityExist(npc1) or IsEntityDead(npc1) then
                winner = npc2
                break
            elseif not DoesEntityExist(npc2) or IsEntityDead(npc2) then
                winner = npc1
                break
            end
        end

        if DoesEntityExist(winner) then
            ClearPedTasksImmediately(winner)
            TaskStartScenarioInPlace(winner, "WORLD_HUMAN_CHEERING", 0, true)
            SetEntityCoords(winner, center.x, center.y, center.z)
            SetEntityHealth(winner, GetEntityMaxHealth(winner))
            showingText = true

            CreateThread(function()
                local name = GetEntityModel(winner)
                local label = "VENCEDOR!"
                local time = GetGameTimer() + 5000
                while GetGameTimer() < time do
                    Wait(0)
                    DrawText3D(center, label)
                end
                showingText = false
            end)

            TriggerServerEvent('fightclub:endRound', winner)
        end
    end)
end)

RegisterCommand("startfight", function()
    TriggerServerEvent("fightclub:start")
end)

