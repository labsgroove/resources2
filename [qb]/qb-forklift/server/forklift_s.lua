local QBCore = exports['qb-core']:GetCoreObject()
local hangar1ID = nil
local hangar2ID = nil
local gotowka = {a = 4200, b = 6660} -- zakres od ile do ile wynosi gotowka za wykonanie misji
-----------------------------------
local MisjaAktywna = 0



AddEventHandler('playerDropped', function(DropReason)
	if hangar1ID == source then
	hangar1ID = nil
	end
	
	if hangar2ID == source then
	hangar2ID = nil
	end
end)

RegisterServerEvent('qb-forklift:przejmijHangar')
AddEventHandler('qb-forklift:przejmijHangar', function(ktory)
	if ktory == '1' then
		if hangar1ID == nil then
			hangar1ID = source
			
			TriggerClientEvent("QBCore:Notify", source, "You are taking over the hangar.", "success", 3000)
			
			TriggerClientEvent("QBCore:Notify", source, "Now only you can perform orders here.", "success", 3000)
			TriggerClientEvent("qb-forklift:maszHangar", source)
		else
			
			TriggerClientEvent("QBCore:Notify", source, 'This hangar is already taken by ID '..hangar1ID, "success", 3000)
		end
	elseif ktory == '2' then
		if hangar2ID == nil then
			hangar2ID = source
			
			TriggerClientEvent("QBCore:Notify", source, "You are taking over the hangar.", "success", 3000)
			
			TriggerClientEvent("QBCore:Notify", source, "Now only you can perform orders here.", "success", 3000)
			TriggerClientEvent("qb-forklift:maszHangar", source)
		else
			
			TriggerClientEvent("QBCore:Notify", source, 'This hangar is already taken by ID '..hangar2ID, "success", 3000)
		end
	end
end)



RegisterServerEvent('qb-forklift:wykonanieMisji')
AddEventHandler('qb-forklift:wykonanieMisji', function(premia)
	local _source = source
	local xPlayer = QBCore.Functions.GetPlayer(source)
	local LosujSiano = math.random(gotowka.a,gotowka.b)

	if premia == 'nie' then

	xPlayer.Functions.AddMoney("cash", LosujSiano, "sold-pawn-items")

	TriggerClientEvent("QBCore:Notify", _source, 'Você recebeu $'..LosujSiano..' pelo trabalho', "success", 3000)
	Wait(2500)
	else

	xPlayer.Functions.AddMoney("cash", premia, "sold-pawn-items")

	TriggerClientEvent("QBCore:Notify", _source, 'Você recebeu $'..premia..' pelo trabalho', "success", 3000)
	Wait(2500)
	end
end)

RegisterServerEvent('qb-forklift:OdszedlDalekoo')
AddEventHandler('qb-forklift:OdszedlDalekoo', function()
	if hangar1ID == source then
	hangar1ID = nil
	end
	
	if hangar2ID == source then
	hangar2ID = nil
	end
end)