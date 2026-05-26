local QBCore = exports['qb-core']:GetCoreObject()
local possessaoAtiva = false
local entidadeEspiritual = nil
local cameraEspiritual = nil
local alvoAtual = nil
local distanciaMaxima = 100.0
local armaEspiritual = GetHashKey("weapon_specialcarbine_mk2")
-- Modo procurado (nível aplicado enquanto o espírito estiver ativo)
local modoProcuradoAtivo = false
local nivelProcurado = 4 -- 0-5
-- Configurações de combate do espírito
local meleeExtraDamage = 4000            -- dano extra aplicado por acerto corpo-a-corpo (mantido se quiser usar)
local meleeCooldown = 40             -- ms entre acertos no mesmo alvo (menor = mais rápido)
local meleeHitForce = 100.0            -- força aplicada ao NPC para arremessá-lo (aumentado para arremessar mais longe)
local meleeRange = 1.1                -- distância para considerar um acerto corpo-a-corpo
local _lastHits = {}                  -- registra últimos acertos por entidade

RegisterCommand("devil", function()
    if possessaoAtiva then
        EncerrarPossessao()
        return
    end

    local ped = PlayerPedId()
    local coords = GetEntityCoords(ped)
    local heading = GetEntityHeading(ped)

    QBCore.Functions.Notify("💀 Seu espírito foi libertado do corpo...", "error")

    RequestModel(GetEntityModel(ped))
    while not HasModelLoaded(GetEntityModel(ped)) do Wait(10) end

    -- Jogador invisível e invulnerável
    SetEntityVisible(ped, false, false)
    SetEntityInvincible(ped, true)

    -- Cria o espírito (clone)
    entidadeEspiritual = CreatePed(4, GetEntityModel(ped), coords.x, coords.y, coords.z, heading, true, true)
    SetEntityInvincible(entidadeEspiritual, true)
    SetPedCanRagdoll(entidadeEspiritual, false)
    GiveWeaponToPed(entidadeEspiritual, armaEspiritual, 1, false, true)
    SetCurrentPedWeapon(entidadeEspiritual, armaEspiritual, true)
    SetPedCombatAttributes(entidadeEspiritual, 21, true)
    -- não chamar TaskCombatPed aqui com variável indefinida; o combate será iniciado quando um alvo for encontrado
    SetPedCombatAbility(entidadeEspiritual, 100) -- 0-100, define quão “inteligente” o combatente é

    -- Parâmetros que controlam "quão rápido" pode ir
local desiredBlend = 3.0   -- 0.0 até ~3.0+ (3 = sprint/full run)
local moveRateOverride = 3.0
local maxBlend = 3.0

-- Thread pra manter os overrides enquanto o ped existir (importante!)
Citizen.CreateThread(function()
    while DoesEntityExist(entidadeEspiritual) do
        -- permite que o ped consiga atingir alta velocidade
        SetPedDesiredMoveBlendRatio(entidadeEspiritual, desiredBlend)
        SetPedMoveRateOverride(entidadeEspiritual, moveRateOverride)
        SetPedMaxMoveBlendRatio(entidadeEspiritual, maxBlend)
        Wait(100) -- reaplica a cada 100ms (pode ajustar)
    end
end)

-- Força ele a ir até o alvo (sprint)
-- TASK::TASK_GO_TO_ENTITY(ped, targetEntity, duration, speed, seekRange, unk1, unk2)
-- vamos usar duration=-1 (até chegar), speed=4.0 (valor acima de ~1 = corrida rápida)
TaskGoToEntity(entidadeEspiritual, alvoAtual, -1, 6.0, 1.0, 1073741824, 0)

-- Opcional: quando chegar perto, trocar para combate (ou chamar direto se quiser que vá atirando/corriendo)
Citizen.CreateThread(function()
    local checkDistance = 0.001
    while DoesEntityExist(entidadeEspiritual) and DoesEntityExist(alvoAtual) do
        local dist = #(GetEntityCoords(entidadeEspiritual) - GetEntityCoords(alvoAtual))
        if dist <= checkDistance then
            -- inicia combate ao chegar perto
            TaskCombatPed(entidadeEspiritual, alvoAtual, 0, 21)
            break
        end
        Wait(100)
    end
end)

    possessaoAtiva = true

    -- Câmera em terceira pessoa fixa atrás do espírito
    IniciarCameraTerceiraPessoa(entidadeEspiritual)

    -- Loop principal
    StartPossessao(entidadeEspiritual, ped)
end)

-- Comando para alternar modo procurado no espírito enquanto a possessão estiver ativa
RegisterCommand("procurado", function(source, args)
    if not possessaoAtiva or not entidadeEspiritual or not DoesEntityExist(entidadeEspiritual) then
        QBCore.Functions.Notify("Ative a possessão primeiro.", "error")
        return
    end

    local requested = tonumber(args[1])
    if requested then
        if requested < 0 then requested = 0 end
        if requested > 5 then requested = 5 end
        nivelProcurado = requested
    end

    modoProcuradoAtivo = not modoProcuradoAtivo

    if modoProcuradoAtivo then
        QBCore.Functions.Notify("Modo procurado ativado. Nível: " .. nivelProcurado, "success")
        Citizen.CreateThread(function()
            local ply = PlayerId()
            while modoProcuradoAtivo and possessaoAtiva do
                SetPlayerWantedLevelNoDrop(ply, true)
                SetPlayerWantedLevel(ply, nivelProcurado, false)
                SetPlayerWantedLevelNow(ply, false)
                Wait(1000)
            end
            -- Garantir limpeza caso tenha sido desativado
            if not modoProcuradoAtivo then
                SetPlayerWantedLevelNoDrop(PlayerId(), false)
                SetPlayerWantedLevel(PlayerId(), 0, false)
                SetPlayerWantedLevelNow(PlayerId(), false)
            end
        end)
    else
        QBCore.Functions.Notify("Modo procurado desativado.", "success")
        SetPlayerWantedLevelNoDrop(PlayerId(), false)
        SetPlayerWantedLevel(PlayerId(), 0, false)
        SetPlayerWantedLevelNow(PlayerId(), false)
    end
end)

function StartPossessao(pedEspiritual, pedOriginal)
    Citizen.CreateThread(function()
        local alvoAnterior = nil

        while possessaoAtiva do
            AtualizarPosicaoJogador(pedOriginal, pedEspiritual)

            local novoAlvo = GetClosestNPCValido(pedEspiritual)

            if novoAlvo and DoesEntityExist(novoAlvo) then
                -- Se mudou de alvo ou o anterior morreu/fugiu
                if novoAlvo ~= alvoAnterior or IsPedFleeing(alvoAnterior) or IsEntityDead(alvoAnterior) then
                    alvoAtual = novoAlvo
                    alvoAnterior = novoAlvo

                    ClearPedTasksImmediately(pedEspiritual)
                    TaskCombatPed(pedEspiritual, alvoAtual, 0, 16)
                    SetPedKeepTask(pedEspiritual, true)
                end
            else
                alvoAtual = nil
                ClearPedTasks(pedEspiritual)
                TaskWanderStandard(pedEspiritual, 10.0, 10)
            end

            Wait(1000)
        end
    end)
end

-- Mantém o jogador invisível seguindo o espírito
function AtualizarPosicaoJogador(pedOriginal, pedEspiritual)
    local espCoords = GetEntityCoords(pedEspiritual)
    local forward = GetEntityForwardVector(pedEspiritual)
    local followPos = espCoords - forward * 1.0 + vector3(0, 0, 0.5) -- atrás e um pouco acima
    SetEntityCoordsNoOffset(pedOriginal, followPos.x, followPos.y, followPos.z, false, false, false)
end

-- Busca NPC mais próximo
-- Busca NPC mais próximo e válido (não fugindo)
function GetClosestNPCValido(ped)
    local coords = GetEntityCoords(ped)
    local handle, npc = FindFirstPed()
    local success
    local closestNPC = nil
    local closestDist = distanciaMaxima

    repeat
        if npc and DoesEntityExist(npc)
    and not IsPedAPlayer(npc)
    and not IsEntityDead(npc)
    and npc ~= ped
    and npc ~= entidadeEspiritual
    and not IsPedFleeing(npc)   -- ignora NPCs fugindo
    and not IsPedInAnyVehicle(npc, false)  -- ignora NPCs em veículos 🚗
then

            local npcCoords = GetEntityCoords(npc)
            local dist = #(coords - npcCoords)
            if dist < closestDist then
                closestDist = dist
                closestNPC = npc
            end
        end
        success, npc = FindNextPed(handle)
    until not success

    EndFindPed(handle)
    return closestNPC
end


-- Câmera fixa atrás do espírito (sem seguir manualmente)
function IniciarCameraTerceiraPessoa(pedEspiritual)
    if DoesCamExist(cameraEspiritual) then
        DestroyCam(cameraEspiritual, false)
    end

    cameraEspiritual = CreateCam("DEFAULT_SCRIPTED_CAMERA", true)
    SetCamActive(cameraEspiritual, true)
    RenderScriptCams(true, false, 0, true, true)

    -- Parâmetros de suavização
    local smoothSpeed = 0.15  -- menor = mais suave
    local camOffset = vector3(0.0, -4.5, 1.8) -- posição atrás e acima

    Citizen.CreateThread(function()
        while possessaoAtiva and DoesEntityExist(pedEspiritual) do
            local espCoords = GetEntityCoords(pedEspiritual)
            local espRot = GetEntityRotation(pedEspiritual, 2)
            local forward = GetEntityForwardVector(pedEspiritual)

            -- Posição desejada (atrás e um pouco acima)
            local desiredPos = espCoords + (forward * camOffset.y) + vector3(0, 0, camOffset.z)

            -- Posição atual da câmera
            local camPos = GetCamCoord(cameraEspiritual)

            -- Lerp posição (transição suave)
            local newPos = vector3(
                camPos.x + (desiredPos.x - camPos.x) * smoothSpeed,
                camPos.y + (desiredPos.y - camPos.y) * smoothSpeed,
                camPos.z + (desiredPos.z - camPos.z) * smoothSpeed
            )

            SetCamCoord(cameraEspiritual, newPos.x, newPos.y, newPos.z)
            PointCamAtCoord(cameraEspiritual, espCoords.x, espCoords.y, espCoords.z + 1.2)

            Wait(0) -- a cada frame
        end

        -- Reset ao sair
        RenderScriptCams(false, false, 0, true, true)
        DestroyCam(cameraEspiritual, false)
        cameraEspiritual = nil
    end)
end


-- Thread para aplicar dano extra, cooldown e efeito de impacto que arremessa NPCs
Citizen.CreateThread(function()
    while true do
        if possessaoAtiva and DoesEntityExist(entidadeEspiritual) then
            local espCoords = GetEntityCoords(entidadeEspiritual)
            local handle, npc = FindFirstPed()
            local success = false
            repeat
                if npc and DoesEntityExist(npc) and not IsPedAPlayer(npc) and not IsEntityDead(npc) and npc ~= entidadeEspiritual then
                    local npcCoords = GetEntityCoords(npc)
                    local dist = #(espCoords - npcCoords)
                    if dist <= meleeRange then
                        local now = GetGameTimer()
                        local last = _lastHits[npc] or 0
                        if now - last >= meleeCooldown then
                            -- Verificações adicionais para evitar ativação apenas por proximidade:
                            -- 1) alvo deve estar aproximadamente à frente (cone)
                            -- 2) espírito deve estar em combate corpo-a-corpo ou o alvo deve ter sido danificado pelo espírito
                            local forward = GetEntityForwardVector(entidadeEspiritual)
                            local toNpcX = npcCoords.x - espCoords.x
                            local toNpcY = npcCoords.y - espCoords.y
                            local dist2D = math.sqrt(toNpcX * toNpcX + toNpcY * toNpcY)
                            local nx, ny = 0.0, 0.0
                            if dist2D > 0.1 then
                                nx = toNpcX / dist2D
                                ny = toNpcY / dist2D
                            end
                            local dot = forward.x * nx + forward.y * ny

                            -- threshold: quanto maior, mais frontal (0.5 ~= 60° cone)
                            local frontThreshold = 0.6

                            -- checa se o espírito está efetivamente atacando em corpo-a-corpo
                            local inMelee = IsPedInMeleeCombat(entidadeEspiritual)
                            -- checa se o alvo foi recentemente danificado pelo espírito (quando o ataque nativo gerou dano)
                            local wasDamaged = HasEntityBeenDamagedByEntity(npc, entidadeEspiritual, true)

                            if dot >= frontThreshold and (inMelee or wasDamaged) then
                                local alvoHeading = GetEntityHeading(npc)
                                local alvoCoords = GetEntityCoords(npc)
                                local offset = GetOffsetFromEntityInWorldCoords(npc, 0.0, -0.8, 0.0) -- posição logo atrás do alvo

                                -- Dash sobrenatural: teleporta o espírito pra posição de ataque ideal
                                SetEntityCoordsNoOffset(entidadeEspiritual, offset.x, offset.y, offset.z, false, false, false)
                                SetEntityHeading(entidadeEspiritual, alvoHeading)

                                -- Efeito de energia sombria
                                UseParticleFxAssetNextCall("core")
                                local fx = StartParticleFxNonLoopedAtCoord("ent_dst_elec_fire_sp", alvoCoords.x, alvoCoords.y, alvoCoords.z + 0.8, 0.0, 0.0, 0.0, 1.2, false, false, false)
                                
                                -- Som de impacto sobrenatural
                                PlaySoundFromEntity(-1, "Hit_1", npc, "WASTED_SOUNDS", 0, 0)

                                -- Delay mínimo pro swing parecer natural
                                Citizen.Wait(170)

                                -- Ragdoll e impacto físico
                                SetPedToRagdoll(npc, 2000, 2000, 0, false, false, false)

                                -- Calcula direção e aplica força
                                local forward = GetEntityForwardVector(entidadeEspiritual)
                                local pushX = forward.x * meleeHitForce
                                local pushY = forward.y * meleeHitForce
                                local pushZ = meleeHitForce * 0.9

                                ApplyForceToEntityCenterOfMass(npc, 1, pushX, pushY, pushZ, 0, 0, 0, true, true, true, false)
                                SetEntityVelocity(npc, pushX, pushY, pushZ)

                                    Citizen.Wait(150)
                                if DoesEntityExist(npc) and not IsEntityDead(npc) then
                                    -- define saúde para zero para matar instantaneamente
                                    SetEntityHealth(npc, 0)
                                end
                                -- Atualiza cooldown
                                _lastHits[npc] = GetGameTimer()

                                -- Partícula secundária tipo “poeira do impacto”
                                UseParticleFxAssetNextCall("core")
                                StartParticleFxNonLoopedAtCoord("ent_anim_puff", alvoCoords.x, alvoCoords.y, alvoCoords.z, 0.0, 0.0, 0.0, 1.0, false, false, false)
                                
                            end
                        end
                    end
                end
                success, npc = FindNextPed(handle)
            until not success
            EndFindPed(handle)
            Wait(50)
        else
            Wait(500)
        end
    end
end)

function EncerrarPossessao()
    if not possessaoAtiva then return end

    local ped = PlayerPedId()
    possessaoAtiva = false

    local destino = nil
    if entidadeEspiritual and DoesEntityExist(entidadeEspiritual) then
        destino = GetEntityCoords(entidadeEspiritual)
        DeleteEntity(entidadeEspiritual)
    end

    if cameraEspiritual then
        RenderScriptCams(false, false, 0, true, true)
        DestroyCam(cameraEspiritual, false)
        cameraEspiritual = nil
    end

    -- Restaura o jogador
    if destino then
        SetEntityCoords(ped, destino.x, destino.y, destino.z)
    end
    SetEntityVisible(ped, true, false)
    SetEntityInvincible(ped, false)
    -- Se o modo procurado estiver ativo, limpa o nível de procurado do jogador
    if modoProcuradoAtivo then
        SetPlayerWantedLevelNoDrop(PlayerId(), false)
        SetPlayerWantedLevel(PlayerId(), 0, false)
        SetPlayerWantedLevelNow(PlayerId(), false)
        modoProcuradoAtivo = false
    end

    QBCore.Functions.Notify("😵‍💫 O espírito retornou ao corpo físico.", "success")
end
