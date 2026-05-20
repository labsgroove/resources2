local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
AddEventHandler('QBCore:Client:OnPlayerLoaded', function(xPlayer)
	PlayerData = xPlayer
end)

local Models = {
	"u_m_y_zombie_01",
    "g_f_m_undeadmage",
    "g_m_m_zombie_04",
    "ig_skeleton_01",
    "u_m_o_filmnoir",
}
  
local walks = {
	"move_m@drunk@verydrunk",
	"move_m@drunk@moderatedrunk",
	"move_m@drunk@a",
	"anim_group_move_ballistic",
	"move_lester_CaneUp",
}

players = {}

RegisterNetEvent("qb-zombies:playerupdate")
AddEventHandler("qb-zombies:playerupdate", function(mPlayers)
	players = mPlayers
end)

entitys = {}

-- Corpse tracking: keep a queue of corpse entities and remove oldest when limit exceeded
local corpses = {}          -- array of { entity = <ent>, time = <GetGameTimer()> }
local corpseTracked = {}    -- map entity -> true when already added to corpses

local function removeCorpseRecord(entity)
	-- remove from corpses array
	for k,v in ipairs(corpses) do
		if v.entity == entity then
			table.remove(corpses, k)
			break
		end
	end
	corpseTracked[entity] = nil
end

local function DeleteZombieEntity(entity)
	if not DoesEntityExist(entity) then
		-- ensure tracking cleaned
		corpseTracked[entity] = nil
		return
	end

	-- clean corpse tracking if present
	if corpseTracked[entity] then
		removeCorpseRecord(entity)
	else
		-- also attempt to remove from corpses array just in case
		for k,v in ipairs(corpses) do
			if v.entity == entity then
				table.remove(corpses, k)
				break
			end
		end
	end

	-- remove from main entitys list
	for k,v in pairs(entitys) do
		if v == entity then
			table.remove(entitys, k)
			break
		end
	end

	local model = GetEntityModel(entity)
	SetEntityAsNoLongerNeeded(entity)
	SetModelAsNoLongerNeeded(model)
	DeleteEntity(entity)
end

local function enforceCorpseLimit()
	while #corpses > (Config.MaxCorpses or 25) do
		-- find oldest corpse (smallest time)
		local idx = 1
		local oldest = corpses[1].time
		for i = 2, #corpses do
			if corpses[i].time < oldest then
				idx = i
				oldest = corpses[i].time
			end
		end
		local ent = corpses[idx].entity
		-- remove the oldest corpse entity from world
		removeCorpseRecord(ent)
		if DoesEntityExist(ent) then
			local model = GetEntityModel(ent)
			SetEntityAsNoLongerNeeded(ent)
			SetModelAsNoLongerNeeded(model)
			DeleteEntity(ent)
		end
		-- also ensure it's not left in main entity list
		for k,v in pairs(entitys) do
			if v == ent then
				table.remove(entitys, k)
				break
			end
		end
	end
end

TriggerServerEvent("RegisterNewZombie")
TriggerServerEvent("qb-zombies:newplayer", PlayerId())

-- Função para verificar se está dentro da área de zumbi
function IsInZombieArea(x, y, z)
    local area = Config.ZombieArea
    local dist = Vdist(x, y, z, area.center.x, area.center.y, area.center.z)
    return dist <= area.radius
end

RegisterNetEvent("ZombieSync")
AddEventHandler("ZombieSync", function()

	AddRelationshipGroup("zombie")
	SetRelationshipBetweenGroups(0, GetHashKey("zombie"), GetHashKey("PLAYER"))
	SetRelationshipBetweenGroups(2, GetHashKey("PLAYER"), GetHashKey("zombie"))

	while true do
		Wait(1)
		if #entitys < Config.SpawnZombie then

			x, y, z = table.unpack(GetEntityCoords(GetPlayerPed(-1), true))

			-- Só spawna se o player estiver dentro da área de zumbi
			if not IsInZombieArea(x, y, z) then
				goto continue
			end

			EntityModel = Models[math.random(1, #Models)]
			EntityModel = string.upper(EntityModel)
			RequestModel(GetHashKey(EntityModel))
			while not HasModelLoaded(GetHashKey(EntityModel)) or not HasCollisionForModelLoaded(GetHashKey(EntityModel)) do
				Wait(1)
			end

			local posX, posY, posZ
			repeat
				Wait(1)
				local angle = math.random() * 2 * math.pi
				local radius = math.random(Config.MinSpawnDistance, Config.MaxSpawnDistance)
				posX = Config.ZombieArea.center.x + math.cos(angle) * radius
				posY = Config.ZombieArea.center.y + math.sin(angle) * radius
				_, posZ = GetGroundZFor_3dCoord(posX, posY, Config.ZombieArea.center.z, 1)
				canSpawn = IsInZombieArea(posX, posY, posZ)
			until canSpawn

			entity = CreatePed(4, GetHashKey(EntityModel), posX, posY, posZ, Config.ZombieArea.heading, true, false)

			walk = walks[math.random(1, #walks)]
						
			RequestAnimSet(walk)
			while not HasAnimSetLoaded(walk) do
				Wait(1)
			end
			SetPedMaxHealth(entity, 140)
			SetEntityHealth(entity, 140)
			SetEntityMaxSpeed(entity, 100.0)
			SetPedPathCanUseClimbovers(entity, true)
			SetPedPathCanUseLadders(entity, false)
			SetPedHearingRange(entity, 20000)
			SetPedMovementClipset(entity, walk, 1.4)
			TaskWanderStandard(entity, 1.0, 10)
			SetCanAttackFriendly(entity, true, false)
			SetPedCanEvasiveDive(entity, false)
			SetPedCombatAbility(entity, 75)
			SetPedAsEnemy(entity,false)
			SetPedAlertness(entity,3)
			SetPedIsDrunk(entity, true)
			SetPedConfigFlag(entity,100,1)
			ApplyPedDamagePack(entity,"BigHitByVehicle", 0.0, 9.0)
			ApplyPedDamagePack(entity,"SCR_Dumpster", 0.0, 9.0)
			ApplyPedDamagePack(entity,"SCR_Torture", 0.0, 9.0)
			DisablePedPainAudio(entity, false)
			SetPedRandomProps(entity)
			StopPedSpeaking(entity,true)
			SetEntityAsMissionEntity(entity, true, true)
			SetAiMeleeWeaponDamageModifier(0.0)
			SetPedShootRate(entity,  750)
			SetPedCombatAttributes(entity, 46, true)
			SetPedFleeAttributes(entity, 0, 0)
			SetPedCombatRange(entity, 2)
			SetPedCombatMovement(entity, 46)
			TaskCombatPed(entity, GetPlayerPed(-1), 0,16)
			TaskLeaveVehicle(entity, vehicle, 0)

			if not NetworkGetEntityIsNetworked(entity) then
				NetworkRegisterEntityAsNetworked(entity)
			end

			table.insert(entitys, entity)
		end	

		for i, entity in pairs(entitys) do
			if not DoesEntityExist(entity) then
				DeleteZombieEntity(entity)
			else
				local pedX, pedY, pedZ = table.unpack(GetEntityCoords(entity, true))
				-- Remove zumbi se sair da área
				if not IsInZombieArea(pedX, pedY, pedZ) then
					DeleteZombieEntity(entity)
				end
			end
			if IsEntityInWater(entity) then
				DeleteZombieEntity(entity)
				
			end
		end
		::continue::
	end
end)

--Zombie sounds
CreateThread(function()
    while true do
        Wait(10000)
        for i, entity in pairs(entitys) do
	       	playerX, playerY, playerZ = table.unpack(GetEntityCoords(GetPlayerPed(-1), true))
			pedX, pedY, pedZ = table.unpack(GetEntityCoords(entity, true))
			if IsPedDeadOrDying(entity, 1) == 1 then
				--none :v
			else
				if(Vdist(playerX, playerY, playerZ, pedX, pedY, pedZ) <= 10.0 ) then

					TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 5.0, "Codzombie", 1.0)

				end
			end
		end
	end
end)

-- Track newly dead zombies and add them to corpse queue; enforce limit
CreateThread(function()
	while true do
		Wait(1000)
		for i, entity in pairs(entitys) do
			if DoesEntityExist(entity) and IsPedDeadOrDying(entity, 1) == 1 and not corpseTracked[entity] then
				corpseTracked[entity] = true
				table.insert(corpses, { entity = entity, time = GetGameTimer() })
				enforceCorpseLimit()
			end
		end
	end
end)

CreateThread(function()
	while true do
		Wait(1000)
		for i, entity in pairs(entitys) do
			for j, player in pairs(players) do
				local playerX, playerY, playerZ = table.unpack(GetEntityCoords(GetPlayerPed(player), true))
				local distance = GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(player)), GetEntityCoords(entity), true)
				
				if distance <= 5.0 then --------------------------------cange distance
					TaskGoToEntity(entity, GetPlayerPed(player), -1, 0.0, 1.0, 1073741824, 0)
				end
			end
		end
	end
end)

CreateThread(function()
    while true do
        Wait(1)
        for i, entity in pairs(entitys) do
	       	playerX, playerY, playerZ = table.unpack(GetEntityCoords(GetPlayerPed(-1), true))
			pedX, pedY, pedZ = table.unpack(GetEntityCoords(entity, true))
			if IsPedDeadOrDying(entity, 1) == 1 then
				--none :v
			else
				if(Vdist(playerX, playerY, playerZ, pedX, pedY, pedZ) < 0.6)then
					if IsPedRagdoll(entity, 1) ~= 1 then
						if not IsPedGettingUp(entity) then
							RequestAnimDict("misscarsteal4@actor")
							TaskPlayAnim(entity,"misscarsteal4@actor","stumble",1.0, 1.0, 500, 9, 1.0, 0, 0, 0)
							local playerPed = (GetPlayerPed(-1))
							local maxHealth = GetEntityMaxHealth(playerPed)
							local health = GetEntityHealth(playerPed)
							local newHealth = health - 2 
							SetEntityHealth(playerPed, newHealth)
							Wait(2000)	
							TaskGoToEntity(entity, GetPlayerPed(-1), -1, 0.0, 1.0, 1073741824, 0)
							--TaskGoStraightToCoord(entity, playerX, playerY, playerZ, 1.0, 0, 0,0)
						end
					end
				end
			end
		end
	end
end)

-- No Health Recharge Function
if Config.NotHealthRecharge then
	SetPlayerHealthRechargeMultiplier(PlayerId(), 0.0)
end

-- Mute Ambience Function
if Config.MuteAmbience then
	StartAudioScene('CHARACTER_CHANGE_IN_SKY_SCENE')
end

-- Set Player Stats Function 
CreateThread( function()
	while true do
		Wait(0)
		RestorePlayerStamina(PlayerId(), 1.0)

		SetPlayerMeleeWeaponDamageModifier(PlayerId(), 0.1)
		SetPlayerMeleeWeaponDefenseModifier(PlayerId(), 0.0)
		SetPlayerWeaponDamageModifier(PlayerId(), 0.4)
		SetPlayerTargetingMode(2)

	end
end)

-- Zombie Loot Drop Function
if Config.ZombieDropLoot then
	CreateThread(function()
		while true do
			Wait(1)
			for i, entity in pairs(entitys) do
				playerX, playerY, playerZ = table.unpack(GetEntityCoords(GetPlayerPed(-1), true))
				pedX, pedY, pedZ = table.unpack(GetEntityCoords(entity, true))
				if DoesEntityExist(entity) == false then
					table.remove(entitys, i)
				end
				if IsPedDeadOrDying(entity, 1) == 1 then
					if GetPedSourceOfDeath(entity) == PlayerPedId() then
						playerX, playerY, playerZ = table.unpack(GetEntityCoords(GetPlayerPed(-1), true))
						pedX, pedY, pedZ = table.unpack(GetEntityCoords(entity, true))	
						if not IsPedInAnyVehicle(PlayerPedId(), false) then
							if(Vdist(playerX, playerY, playerZ, pedX, pedY, pedZ) < 4.0) then
								QBCore.Functions.DrawText3D(pedX, pedY, pedZ + 0.2, 'Search Zombie - [~g~E~w~]')
								if IsControlJustReleased(1, 51) then
									if DoesEntityExist(GetPlayerPed(-1)) then
										RequestAnimDict("random@domestic")
										while not HasAnimDictLoaded("random@domestic") do
											Wait(1)
										end
										TaskPlayAnim(PlayerPedId(), "random@domestic", "pickup_low", 8.0, -8, 2000, 2, 0, 0, 0, 0)
										Wait(2000)
										randomChance = math.random(1, 100)
										if randomChance < Config.ProbabilityMoneyLoot then
											TriggerServerEvent('qb-zombies:moneyloot')
										elseif randomChance >= Config.ProbabilityMoneyLoot and randomChance < Config.ProbabilityItemLoot then
											TriggerServerEvent('qb-zombies:itemloot')
										elseif randomChance >= Config.ProbabilityItemLoot and randomChance < 100 then
											QBCore.Functions.Notify('You found nothing','error')
										end
											
										ClearPedSecondaryTask(GetPlayerPed(-1))
										-- ensure tracking cleaned up
										DeleteZombieEntity(entity)
									end
								end
							end
						end
					end
				end
			end
		end
	end)
end

-- Clear All Zombies Function
RegisterNetEvent('qb-zombies:clear')
AddEventHandler('qb-zombies:clear', function()
	for i, entity in pairs(entitys) do
		local model = GetEntityModel(entity)
		-- use centralized deletion so corpse tracking stays consistent
		DeleteZombieEntity(entity)
	end
end)


-- Debug Function
if Config.Debug then
	CreateThread(function()
		while true do
			Wait(1)
			for i, entity in pairs(entitys) do
				local playerX, playerY, playerZ = table.unpack(GetEntityCoords(PlayerPedId(), true))
				local pedX, pedY, pedZ = table.unpack(GetEntityCoords(entity, false))	
				DrawLine(playerX, playerY, playerZ, pedX, pedY, pedZ, 250,0,0,250)
			end
		end
	end)
end

-- No PEDs Function
if Config.NoPeds then
	CreateThread(function()
		while true do
			Wait(1)
	    	SetVehicleDensityMultiplierThisFrame(0.0)
			SetPedDensityMultiplierThisFrame(0.0)
			SetRandomVehicleDensityMultiplierThisFrame(0.0)
			SetParkedVehicleDensityMultiplierThisFrame(0.0)
			SetScenarioPedDensityMultiplierThisFrame(0.0, 0.0)
			local playerPed = GetPlayerPed(-1)
			local pos = GetEntityCoords(playerPed) 
			RemoveVehiclesFromGeneratorsInArea(pos['x'] - 500.0, pos['y'] - 500.0, pos['z'] - 500.0, pos['x'] + 500.0, pos['y'] + 500.0, pos['z'] + 500.0);
			SetGarbageTrucks(0)
			SetRandomBoats(0)
			CancelCurrentPoliceReport()
			
			for i=0,20 do
				EnableDispatchService(i, false)
			end
		end
	end)
end

local hunterPed = nil
local hunterTarget = nil
local deletingZombies = {}
local hunterCam = nil -- câmera do caçador

-- Comando para ativar a câmera espectador no caçador
RegisterCommand('zombcam', function()
    if hunterPed and DoesEntityExist(hunterPed) then
        if hunterCam and DoesCamExist(hunterCam) then
            QBCore.Functions.Notify('Câmera já está ativa no caçador!')
            return
        end
        local hx, hy, hz = table.unpack(GetEntityCoords(hunterPed, true))
        hunterCam = CreateCam('DEFAULT_SCRIPTED_CAMERA', true)
        SetCamCoord(hunterCam, hx, hy, hz + 2.0)
        PointCamAtEntity(hunterCam, hunterPed, 0.0, 0.0, 1.0, true)
        AttachCamToEntity(hunterCam, hunterPed, 0.0, -3.0, 2.0, true)
        SetCamActive(hunterCam, true)
        RenderScriptCams(true, false, 0, true, true)
        QBCore.Functions.Notify('Modo espectador ativado no caçador!')
    else
        QBCore.Functions.Notify('Nenhum caçador ativo para focar!')
    end
end, false)

-- Comando para desativar a câmera espectador
RegisterCommand('zombcamoff', function()
    if hunterCam and DoesCamExist(hunterCam) then
        RenderScriptCams(false, false, 0, true, true)
        DestroyCam(hunterCam, false)
        hunterCam = nil
        QBCore.Functions.Notify('Modo espectador desativado!')
    else
        QBCore.Functions.Notify('Câmera do caçador não está ativa!')
    end
end, false)

-- Comando principal
RegisterCommand('zomb', function()
    if hunterPed and DoesEntityExist(hunterPed) then
        QBCore.Functions.Notify('Já existe um caçador ativo! Use /zomboff para remover.')
        return
    end

    CreateZombieHunter()
end, false)

-- Remoção
RegisterCommand('zomboff', function()
    if hunterPed and DoesEntityExist(hunterPed) then
        DeleteEntity(hunterPed)
        hunterPed = nil
        QBCore.Functions.Notify('Caçador de zumbis removido!')
    else
        QBCore.Functions.Notify('Nenhum caçador ativo.')
    end
end, false)

-- Função para criar e ativar o caçador
function CreateZombieHunter()
    local playerPed = PlayerPedId()
    local x, y, z = table.unpack(GetEntityCoords(playerPed, true))
    local heading = GetEntityHeading(playerPed)
    local hunterModel = GetHashKey('player_two')

    RequestModel(hunterModel)
    while not HasModelLoaded(hunterModel) do Wait(10) end

    hunterPed = CreatePed(4, hunterModel, x + 2.0, y, z, heading, true, true)
    
    SetPedAsGroupMember(hunterPed, GetPedGroupIndex(playerPed))
    SetEntityInvincible(hunterPed, false)
    SetPedCanRagdoll(hunterPed, true)
    SetPedFleeAttributes(hunterPed, 0, 0)
    SetPedCombatAttributes(hunterPed, 46, true) -- Disposto a matar tudo
    SetPedCombatAbility(hunterPed, 2)
    SetPedCombatRange(hunterPed, 2)
    SetPedCombatMovement(hunterPed, 2)
    SetPedRelationshipGroupHash(hunterPed, GetHashKey('PLAYER'))
    GiveWeaponToPed(hunterPed, GetHashKey('weapon_raycarbine'), 9999, false, true)
    SetCurrentPedWeapon(hunterPed, GetHashKey('weapon_raycarbine'), true)

    QBCore.Functions.Notify('Caçador de zumbis ativado!')

    -- Thread de comportamento do hunter
    CreateThread(function()
        while hunterPed and DoesEntityExist(hunterPed) do
            Wait(150)

            local hx, hy, hz = table.unpack(GetEntityCoords(hunterPed, true))
            local closestZombie = nil
            local minDist = 100.0

            for _, entity in pairs(entitys) do
                if DoesEntityExist(entity) and not IsPedDeadOrDying(entity, 1) then
                    local zx, zy, zz = table.unpack(GetEntityCoords(entity, true))
                    local dist = Vdist(hx, hy, hz, zx, zy, zz)
                    if dist < minDist then
                        minDist = dist
                        closestZombie = entity
                    end
                end
            end

            if closestZombie then
                TaskCombatPed(hunterPed, closestZombie, 0, 16)

                -- Só remove se ainda não estiver na fila
                local zombieNetId = NetworkGetNetworkIdFromEntity(closestZombie)
					if not deletingZombies[zombieNetId] then
						deletingZombies[zombieNetId] = true
						CreateThread(function()
							while DoesEntityExist(closestZombie) and not IsPedDeadOrDying(closestZombie, true) do
								Wait(100)
							end
							if DoesEntityExist(closestZombie) then
								Wait(5000)
								-- use centralized deletion so corpse tracking is consistent
								DeleteZombieEntity(closestZombie)
							end
							deletingZombies[zombieNetId] = nil
						end)
					end
            else
                -- Sem alvos, andar pelo mapa
                ClearPedTasks(hunterPed)
                TaskWanderStandard(hunterPed, 1.0, 10)
            end
        end
    end)
end
