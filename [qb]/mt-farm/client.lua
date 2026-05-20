local QBCore = exports['qb-core']:GetCoreObject()
local spawnedPlants = 0
local FarmPlants = {}

-- Loja

RegisterNetEvent('mt-farm:client:MenuLoja', function(data)
    exports['qb-menu']:openMenu({
        {
            header = "Loja da fazenda",
            isMenuHeader = true,
        },
        {
            header = "< Fechar",
            params = {
                event = "qb-menu:closeMenu",
            }
        },
        {
            header = "Comprar Acessórios",
            txt = "",
            params = {
                event = "mt-farm:client:MenuAcessorios",
            }
        },
        {
            header = "Comprar Sementes",
            txt = "",
            params = {
                event = "mt-farm:client:MenuSementes",
            }
        },
    })
end)

RegisterNetEvent('mt-farm:client:MenuAcessorios', function(data)
    exports['qb-menu']:openMenu({
        {
            header = "Farm shop - Acessorios",
            isMenuHeader = true,
        },
        {
            header = "< Voltar",
            params = {
                event = "mt-farm:client:MenuLoja",
            }
        },
        {
            header = "Comprar Fertilizante",
            txt = "Price: 10$ per 1",
            params = {
                event = "mt-farm:client:ComprarFertilizante",
            }
        },
        {
            header = "Comprar regador",
            txt = "Price: 10$ per 1",
            params = {
                event = "mt-farm:client:ComprarRegador",
            }
        },
        {
            header = "Comprar Pá",
            txt = "Price: 50$ per 1",
            params = {
                event = "mt-farm:client:ComprarPa",
            }
        },
        {
            header = "Comprar Tesoura",
            txt = "Price: 20$ per 1",
            params = {
                event = "mt-farm:client:ComprarTesoura",
            }
        },
    })
end)

RegisterNetEvent('mt-farm:client:MenuSementes', function()
    exports['qb-menu']:openMenu({
        {
            header = "Farm shop - Sementes",
            isMenuHeader = true,
        },
        {
            header = "< Back",
            params = {
                event = "mt-farm:client:MenuLoja",
            }
        },
        {
            header = "Semente de tomate",
            txt = "Price: 20$ per 1",
            params = {
                event = "mt-farm:client:ComprarTomate",
            }
        },
        {
            header = "Semente de trigo",
            txt = "Price: 20$ per 1",
            params = {
                event = "mt-farm:client:ComprarTrigo",
            }
        },
        {
            header = "Semente de batata",
            txt = "Price: 20$ per 1",
            params = {
                event = "mt-farm:client:ComprarBatatas",
            }
        },
        {
            header = "Semente de pepino",
            txt = "Price: 20$ per 1",
            params = {
                event = "mt-farm:client:ComprarPepino",
            }
        },
        {
            header = "Semente de cebola",
            txt = "Price: 20$ per 1",
            params = {
                event = "mt-farm:client:ComprarCebola",
            }
        },
        {
            header = "Semente de couve",
            txt = "Price: 20$ per 1",
            params = {
                event = "mt-farm:client:ComprarCove",
            }
        },
        {
            header = "Semente de alface",
            txt = "Price: 20$ per 1",
            params = {
                event = "mt-farm:client:ComprarAlface",
            }
        },
        {
            header = "Semente de cenoura",
            txt = "Price: 20$ per 1",
            params = {
                event = "mt-farm:client:ComprarCenora",
            }
        },
        {
            header = "Semente de beterraba",
            txt = "Price: 20$ per 1",
            params = {
                event = "mt-farm:client:ComprarBeterraba",
            }
        },
        {
            header = "Semente de nabo",
            txt = "Price: 20$ per 1",
            params = {
                event = "mt-farm:client:ComprarNabo",
            }
        },
        {
            header = "Esporos de cogumelos",
            txt = "Price: 20$ per 1",
            params = {
                event = "mt-farm:client:ComprarCogumelos",
            }
        },
    })
end)

RegisterNetEvent('mt-farm:client:ComprarFertilizante', function()
    TriggerServerEvent('mt-farm:server:ComprarFertilizante')
    TriggerEvent('mt-farm:client:MenuAcessorios')
end)

RegisterNetEvent('mt-farm:client:ComprarTomate', function()
    TriggerServerEvent('mt-farm:server:ComprarTomate')
    TriggerEvent('mt-farm:client:MenuSementes')
end)

RegisterNetEvent('mt-farm:client:ComprarTrigo', function()
    TriggerServerEvent('mt-farm:server:ComprarTrigo')
    TriggerEvent('mt-farm:client:MenuSementes')
end)

RegisterNetEvent('mt-farm:client:ComprarBatatas', function()
    TriggerServerEvent('mt-farm:server:ComprarBatatas')
    TriggerEvent('mt-farm:client:MenuSementes')
end)

RegisterNetEvent('mt-farm:client:ComprarPepino', function()
    TriggerServerEvent('mt-farm:server:ComprarPepino')
    TriggerEvent('mt-farm:client:MenuSementes')
end)

RegisterNetEvent('mt-farm:client:ComprarCebola', function()
    TriggerServerEvent('mt-farm:server:ComprarCebola')
    TriggerEvent('mt-farm:client:MenuSementes')
end)

RegisterNetEvent('mt-farm:client:ComprarCove', function()
    TriggerServerEvent('mt-farm:server:ComprarCove')
    TriggerEvent('mt-farm:client:MenuSementes')
end)

RegisterNetEvent('mt-farm:client:ComprarAlface', function()
    TriggerServerEvent('mt-farm:server:ComprarAlface')
    TriggerEvent('mt-farm:client:MenuSementes')
end)

RegisterNetEvent('mt-farm:client:ComprarCenora', function()
    TriggerServerEvent('mt-farm:server:ComprarCenora')
    TriggerEvent('mt-farm:client:MenuSementes')
end)

RegisterNetEvent('mt-farm:client:ComprarBeterraba', function()
    TriggerServerEvent('mt-farm:server:ComprarBeterraba')
    TriggerEvent('mt-farm:client:MenuSementes')
end)

RegisterNetEvent('mt-farm:client:ComprarNabo', function()
    TriggerServerEvent('mt-farm:server:ComprarNabo')
    TriggerEvent('mt-farm:client:MenuSementes')
end)

RegisterNetEvent('mt-farm:client:ComprarCogumelos', function()
    TriggerServerEvent('mt-farm:server:ComprarCogumelos')
    TriggerEvent('mt-farm:client:MenuSementes')
end)

RegisterNetEvent('mt-farm:client:ComprarRegador', function()
    TriggerServerEvent('mt-farm:server:ComprarRegador')
    TriggerEvent('mt-farm:client:MenuAcessorios')
end)

RegisterNetEvent('mt-farm:client:ComprarPa', function()
    TriggerServerEvent('mt-farm:server:ComprarPa')
    TriggerEvent('mt-farm:client:MenuAcessorios')
end)

RegisterNetEvent('mt-farm:client:ComprarTesoura', function()
    TriggerServerEvent('mt-farm:server:ComprarTesoura')
    TriggerEvent('mt-farm:client:MenuAcessorios')
end)

RegisterNetEvent('mt-farm:client:EncherRegador', function()
    TriggerEvent('animations:client:EmoteCommandStart', {"mechanic4"})
    QBCore.Functions.Progressbar('name_here', 'FILLING WATER CAN...', 5000, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {}, {}, {}, function()
        TriggerEvent('animations:client:EmoteCommandStart', {"c"})
        TriggerServerEvent('mt-farm:server:EncherRegador')
    end)
end)

-- Threads

CreateThread(function()
    RequestModel(`a_m_m_farmer_01`)
      while not HasModelLoaded(`a_m_m_farmer_01`) do
      Wait(1)
    end
      farmshopped = CreatePed(2, `a_m_m_farmer_01`, Config.ShopPed, false, false)
      SetPedFleeAttributes(farmshopped, 0, 0)
      SetPedDiesWhenInjured(farmshopped, false)
      TaskStartScenarioInPlace(farmshopped, "missheistdockssetup1clipboard@base", 0, true)
      SetPedKeepTask(farmshopped, true)
      SetBlockingOfNonTemporaryEvents(farmshopped, true)
      SetEntityInvincible(farmshopped, true)
      FreezeEntityPosition(farmshopped, true)

    exports['qb-target']:AddBoxZone("farmshopped", Config.ShopPedTarget, 1, 1, {
        name="farmshopped",
        heading=0,
        debugpoly = false,
    }, {
        options = {
            {
                event = "mt-farm:client:MenuLoja",
                icon = "fas fa-farm",
                label = "Talk to farmer",
            },
        },
        distance = 1.5
    })
end)

CreateThread(function()
    exports['qb-target']:AddBoxZone("farmwater", Config.WaterLoc, 4, 4, {
        name="farmwater",
        heading=0,
        debugpoly = false,
    }, {
        options = {
            {
                event = "mt-farm:client:EncherRegador",
                icon = "fas fa-dewpoint",
                label = "Fill Water Can",
            },
        },
        distance = 1.5
    })
end)

-- Plantas

crop_type = {
    ["crop_stage"] = {
        stage_1 = {"prop_veg_crop_04_leaf", -1.05},
        stage_2 = {"prop_veg_crop_04_leaf", -1.05},
        stage_3 = {"prop_veg_crop_04_leaf", -1.05},
        stage_4 = {"prop_veg_crop_04_leaf", -1.05},
        stage_5 = {"prop_veg_crop_04_leaf", -1.05},
        stage_6 = {"prop_veg_crop_02", -1.05}
    }
}

Plants = {}
SpawnedPlants = {}
CurrentPlant = nil
CurrentPlantInfo = nil

local nearPlant = true
local shown = false

CreateThread(function(percent)
    while true do 
        if LocalPlayer.state.isLoggedIn then
            local ped = PlayerPedId() 
            local nPlant = nearPlant(ped)
            if nPlant ~= false then
                if not shown then
                    shown = true
                    QBCore.Functions.TriggerCallback("mt-farm:server:getPlant",function(info)
                        CurrentPlant = nPlant
                        CurrentPlantInfo = info
                        if CurrentPlantInfo.food and CurrentPlantInfo.water == 0 then
                            PlantMenuDead()
                        elseif CurrentPlantInfo.stage >= 100 then
                            PlantMenuHaverst()
                        else
                            PlantMenuAlive()
                        end
                    end,nPlant)
                end
            else
                if shown then
                    CurrentPlant = nil
                    CurrentPlantInfo = nil
                    exports['qb-menu']:closeMenu() 
                    shown = false
                end
            end
            if nPlant == false then
                Wait(1000)
            else
                Wait(1)
            end
        end
        Wait(100)
    end
end)

QBCore.Functions.TriggerCallback("mt-farm:server:getInfo",function(plants)
    Plants = plants
    for k, v in pairs(Plants) do
        spawnPlant(v.seed, v.coords, v.info.stage, k)
    end
end)

RegisterNetEvent("mt-farm:client:DeleteEntity",function()
    exports['qb-menu']:closeMenu() 
    Wait(2000)
    if SpawnedPlants[CurrentPlant] ~= nil then
        DeleteEntity(SpawnedPlants[CurrentPlant])
    end
    Plants[CurrentPlant] = nil
    SpawnedPlants[CurrentPlant] = nil
    CurrentPlant = nil
    CurrentPlantInfo = nil
    ClearPedTasks(ped)
    Wait(4000)
    action = false
    ClearPedTasksImmediately(ped)
end)

RegisterNetEvent("mt-farm:client:growPlant",function(id, percent)
    if Plants[id] ~= nil and SpawnedPlants[id] ~= nil then
        setPlant(id, percent)
    end
end)

RegisterNetEvent("mt-farm:client:growthUpdate",function()
    if CurrentPlantInfo ~= nil then
        CurrentPlantInfo.water = CurrentPlantInfo.water - (0.02 * CurrentPlantInfo.rate)
        CurrentPlantInfo.food = CurrentPlantInfo.food - (0.02 * CurrentPlantInfo.rate)
        CurrentPlantInfo.stage = CurrentPlantInfo.stage + (0.01 * CurrentPlantInfo.rate) 
    end
end)

RegisterNetEvent("mt-farm:client:startPlanting",function(plant)
    local ped = PlayerPedId()
    local coords = GetEntityCoords(ped)
    local HasItem = QBCore.Functions.HasItem('farm_pa')

    if HasItem then
        if GetDistanceBetweenCoords(coords, Config.FarmField, true) < 50 then
    TaskStartScenarioInPlace(PlayerPedId(), 'world_human_gardener_plant', 0, false)
    QBCore.Functions.Progressbar("plant_seeds", "PLANTING SEEDS..", 6500, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {}, {}, {}, function()
        TriggerServerEvent("mt-farm:server:addPlantToDatabase", plant, coords)
        end)
        else
            QBCore.Functions.Notify('You are not at farm field...', 'error', 7500)
        end
    else
        QBCore.Functions.Notify('You need a Shovel to plant that...', 'error', 7500)
    end
end)

RegisterNetEvent("mt-farm:client:addPlant",function(seed, coords, id)
    local entity = 'crop_stage'
    local ped = PlayerPedId()
    Plants[id] = {seed = seed, coords = coords}
    SpawnedPlants[id] =CreateObject(GetHashKey(crop_type[entity].stage_1[1]),coords[1],coords[2],coords[3] + crop_type[entity].stage_1[2],false,true,1)
    SetEntityAsMissionEntity(SpawnedPlants[id], true, true)  
end)

RegisterNetEvent('mt-farm:client:cropOptions', function(args, data)
    local args = tonumber(args)
	if args == 1 then
        local percent = Config.FertilizerQuantity
        QBCore.Functions.TriggerCallback('mt-farm:server:VerificarItem', function(HasItem)
            if HasItem then
                QBCore.Functions.Notify("+"..percent.." fertilizer", "success")
                if percent > 0 then
                    CurrentPlantInfo.food = CurrentPlantInfo.food + percent
                    if CurrentPlantInfo.food > 100 then
                        CurrentPlantInfo.food = 100
                    end
                    TaskStartScenarioInPlace(PlayerPedId(), 'world_human_gardener_plant', 0, false)
                    QBCore.Functions.Progressbar('add_fertilizante', 'ADDING FERTILIZER...', 5000, false, true, {
                        disableMovement = true,
                        disableCarMovement = true,
                        disableMouse = false,
                        disableCombat = true,
                    }, { }, {}, {}, function()
                    TriggerServerEvent("mt-farm:server:updatePlant", CurrentPlant, CurrentPlantInfo)
                    TriggerServerEvent("mt-farm:server:RemoveItem", "farm_fertilizante", 1)
                    TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["farm_fertilizante"], "remove", 1) 
                    PlantMenuStacic()
                    end)
                end
            else
                PlantMenuAlive()
                QBCore.Functions.Notify("You dont have any fertilizer", "error")
            end
        end, "farm_fertilizante")
    elseif args == 2 then
        local percent = Config.WaterQuantity
        QBCore.Functions.TriggerCallback('mt-farm:server:VerificarItem', function(HasItem)
            if HasItem then
                QBCore.Functions.Notify("+"..percent.." Water", "success")
                if percent > 0 then
                    CurrentPlantInfo.water = CurrentPlantInfo.water + percent
                    if CurrentPlantInfo.water > 100 then
                        CurrentPlantInfo.water = 100
                    end
                    TriggerEvent('animations:client:EmoteCommandStart', {"mechanic4"})
                    QBCore.Functions.Progressbar('add_water', 'ADDING WATER...', 5000, false, true, {
                        disableMovement = true,
                        disableCarMovement = true,
                        disableMouse = false,
                        disableCombat = true,
                    }, { }, {}, {}, function()
                    TriggerEvent('animations:client:EmoteCommandStart', {"c"})
                    TriggerServerEvent("mt-farm:server:updatePlant", CurrentPlant, CurrentPlantInfo)
                    TriggerServerEvent("mt-farm:server:RemoveItem", "farm_regador_cheio", 1)
                    TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items["farm_regador_cheio"], "remove", 1)
                    PlantMenuStacic()
                    end)
                end
            else
                PlantMenuAlive()
                QBCore.Functions.Notify("You dont have any water", "error")
            end
        end, "farm_regador_cheio")
    elseif args == 3 then
        local ped = PlayerPedId()
        TaskStartScenarioInPlace(ped, "world_human_gardener_plant", 0, false)
        exports['qb-menu']:closeMenu() 
        QBCore.Functions.Progressbar('haverst_plant', 'HAVERSTING PLANT...', 5000, false, true, {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        }, {}, {}, {}, function()
        if SpawnedPlants[CurrentPlant] ~= nil then
            DeleteEntity(SpawnedPlants[CurrentPlant])
        end
        TriggerServerEvent("mt-farm:server:deletePlant", CurrentPlant)
        TriggerServerEvent("mt-farm:server:addAlimento", Plants[CurrentPlant].seed, CurrentPlantInfo) 
        Plants[CurrentPlant] = nil
        SpawnedPlants[CurrentPlant] = nil
        CurrentPlant = nil
        CurrentPlantInfo = nil
        ClearPedTasks(ped)
        ClearPedTasksImmediately(ped)
    end)
    elseif args == 4 then
        local ped = PlayerPedId()
        TaskStartScenarioInPlace(ped, "world_human_gardener_plant", 0, false)
        exports['qb-menu']:closeMenu() 
        QBCore.Functions.Progressbar('delete_plant', 'DESTROYING PLANT...', 5000, false, true, {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        }, {}, {}, {}, function()
        if SpawnedPlants[CurrentPlant] ~= nil then
            DeleteEntity(SpawnedPlants[CurrentPlant])
        end
        Plants[CurrentPlant] = nil
        SpawnedPlants[CurrentPlant] = nil
        TriggerServerEvent("mt-farm:server:deletePlant", CurrentPlant)
        CurrentPlant = nil
        CurrentPlantInfo = nil
        ClearPedTasks(ped)
        ClearPedTasksImmediately(ped)
    end)
    else
        exports['qb-menu']:closeMenu() 
        Wait(100)
        PlantMenuAlive()
    end
end)

function spawnPlant(plant, coords, percent, id)
    local entity = 'crop_stage'
    if percent < 20 then
        SpawnedPlants[id] =CreateObject(GetHashKey(crop_type[entity].stage_1[1]),coords[1],coords[2],coords[3] + crop_type[entity].stage_1[2],false,true,1)
    elseif percent < 30 then
        SpawnedPlants[id] =CreateObject(GetHashKey(crop_type[entity].stage_2[1]),coords[1],coords[2],coords[3] + crop_type[entity].stage_2[2],false,true,1)
    elseif percent < 45 then
        SpawnedPlants[id] =CreateObject(GetHashKey(crop_type[entity].stage_3[1]),coords[1],coords[2],coords[3] + crop_type[entity].stage_3[2],false,true,1)
    elseif percent < 60 then
        SpawnedPlants[id] =CreateObject(GetHashKey(crop_type[entity].stage_4[1]),coords[1],coords[2],coords[3] + crop_type[entity].stage_4[2],false,true,1)
    elseif percent < 85 then
        SpawnedPlants[id] =CreateObject(GetHashKey(crop_type[entity].stage_5[1]),coords[1],coords[2],coords[3] + crop_type[entity].stage_5[2],false,true,1)
    elseif percent <= 100 then
        SpawnedPlants[id] =CreateObject(GetHashKey(crop_type[entity].stage_6[1]),coords[1],coords[2],coords[3] + crop_type[entity].stage_6[2],false,true,1)
    end
    SetEntityAsMissionEntity(SpawnedPlants[id], true, true)
end

function setPlant(id, percent)
    local plant = Plants[id].type
    local entity = 'crop_stage'
    if SpawnedPlants[id] ~= nil then
        local coords = Plants[id].coords
        DeleteEntity(SpawnedPlants[id])
        if percent < 20 then
            SpawnedPlants[id] =CreateObject(GetHashKey(crop_type[entity].stage_1[1]),coords[1],coords[2],coords[3] + crop_type[entity].stage_1[2],false,true,1)
        elseif percent < 30 then
            SpawnedPlants[id] =CreateObject(GetHashKey(crop_type[entity].stage_2[1]),coords[1],coords[2],coords[3] + crop_type[entity].stage_2[2],false,true,1)
        elseif percent < 45 then
            SpawnedPlants[id] =CreateObject(GetHashKey(crop_type[entity].stage_3[1]),coords[1],coords[2],coords[3] + crop_type[entity].stage_3[2],false,true,1)
        elseif percent < 60 then
            SpawnedPlants[id] =CreateObject(GetHashKey(crop_type[entity].stage_4[1]),coords[1],coords[2],coords[3] + crop_type[entity].stage_4[2],false,true,1)
        elseif percent < 85 then
            SpawnedPlants[id] =CreateObject(GetHashKey(crop_type[entity].stage_5[1]),coords[1],coords[2],coords[3] + crop_type[entity].stage_5[2],false,true,1)
        elseif percent <= 100 then
            SpawnedPlants[id] =CreateObject(GetHashKey(crop_type[entity].stage_6[1]),coords[1],coords[2],coords[3] + crop_type[entity].stage_6[2],false,true,1)
        end
        SetEntityAsMissionEntity(SpawnedPlants[id], true, true)
    else
        print("There was an error loading a plant!")
    end
end

function GetGroundHash(ped)
    local posped = GetEntityCoords(ped)
    local num = StartShapeTestCapsule(posped.x, posped.y, posped.z + 4, posped.x, posped.y, posped.z - 2.0, 2, 1, ped, 7)
    local arg1, arg2, arg3, arg4, arg5 = GetShapeTestResultEx(num)
    return arg5
end

function nearPlant(ped)
    for k, v in pairs(Plants) do
        if #(v.coords - GetEntityCoords(ped)) < 1.0 then
            return k
        end
    end
    return false
end

function PlantMenuDead()
    exports['qb-menu']:showHeader({
        {
            header = "Dead Marijuana Plant: "..CurrentPlant,
            txt = "Stage: "..math.floor(CurrentPlantInfo.stage).."%", 
            isMenuHeader = true
        },
        {
            header = "Progress",
            txt = "Stage: "..math.floor(CurrentPlantInfo.stage).."%",
        },
        {
            header = "Destroy dead plant",
            txt = "",
            params = {
                event = "mt-farm:client:cropOptions",
                args = 4
            }
        },
    })
end

function PlantMenuStacic()
    exports['qb-menu']:openMenu({
        { 
            header = "Plant: "..CurrentPlant,
            txt = "",
            isMenuHeader = true
        },
        {
            header = "Progress",
            txt = "Stage: "..math.floor(CurrentPlantInfo.stage).."%<p>Rate: "..math.floor(CurrentPlantInfo.rate).."%",
        },
        {
            header = "Fertilizer",
            txt = "Nutrition: "..math.floor(CurrentPlantInfo.food).."%",
            params = {
                event = "mt-farm:client:cropOptions",
                args = 1
            }
        },
        {
            header = "Water",
            txt = "Water: "..math.floor(CurrentPlantInfo.water).."%",
            params = {
                event = "mt-farm:client:cropOptions",
                args = 2
            }
        },
        {
            header = "Destroy",
            txt = "",
            params = {
                event = "mt-farm:client:cropOptions",
                args = 4
            }
        },
        {
            header = "Return",
            params = {
                event = "mt-farm:client:cropOptions",
                args = 5
            }
        },
    })
end

function PlantMenuAlive()
    exports['qb-menu']:showHeader({
        {
            header = "Plant: "..CurrentPlant,
            txt = "",
            isMenuHeader = true
        },
        {
            header = "Progress",
            txt = "Stage: "..math.floor(CurrentPlantInfo.stage).."%<p>Rate: "..math.floor(CurrentPlantInfo.rate).."%",
        },
        {
            header = "Fertilizer",
            txt = "Nutrition: "..math.floor(CurrentPlantInfo.food).."%",
            params = {
                event = "mt-farm:client:cropOptions",
                args = 1
            }
        },
        {
            header = "Water",
            txt = "Water: "..math.floor(CurrentPlantInfo.water).."%",
            params = {
                event = "mt-farm:client:cropOptions",
                args = 2
            }
        },
        {
            header = "Destroy",
            txt = "",
            params = {
                event = "mt-farm:client:cropOptions",
                args = 4
            }
        },
    })
end

function PlantMenuHaverst()
    exports['qb-menu']:showHeader({
        {
            header = "Plant: "..CurrentPlant,
            txt = "",
            isMenuHeader = true
        },
        {
            header = "Progress",
            txt = "Stage: "..math.floor(CurrentPlantInfo.stage).."%<p>Rate: "..math.floor(CurrentPlantInfo.rate).."%",
        },
        {
            header = "Harvest",
            txt = "",
            params = {
                event = "mt-farm:client:cropOptions",
                args = 3
            }
        },
    })
end

-- Ordenhar vacas

RegisterNetEvent('mt-farm:client:OrdenharVacas', function()
    TriggerEvent('animations:client:EmoteCommandStart', {"mechanic4"})
    QBCore.Functions.Progressbar('ordenhar_vaca', 'MILKING COW...', 5000, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {}, {}, {}, function()
        TriggerServerEvent('mt-farm:server:OrdenharVacas')
        ClearPedTasks(PlayerPedId())
        QBCore.Functions.Notify('You have milked an Cow!', 'success', 7500)
    end)
end)

-- Blips

Citizen.CreateThread(function()
    local blip = AddBlipForRadius(2884.94, 4645.27, 48.65, 100.0)
    
        SetBlipHighDetail(blip, true)
        SetBlipColour(blip, 37)
        SetBlipAlpha (blip, 128)
    
    local blip = AddBlipForCoord(2884.94, 4645.27, 48.65)
    
        SetBlipSprite (blip, 88)
        SetBlipDisplay(blip, 2)
        SetBlipScale  (blip, 0.9)
        SetBlipColour (blip, 37)
        SetBlipAsShortRange(blip, true)
    
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString('Farm Field')
        EndTextCommandSetBlipName(blip)

    local blip = AddBlipForCoord(2931.6, 4624.6, 48.72)
    
        SetBlipSprite (blip, 88)
        SetBlipDisplay(blip, 2)
        SetBlipScale  (blip, 0.9)
        SetBlipColour (blip, 37)
        SetBlipAsShortRange(blip, true)
    
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString('Farm Shop')
        EndTextCommandSetBlipName(blip)

    local blip = AddBlipForCoord(2386.51, 4716.06, 33.65)
    
        SetBlipSprite (blip, 88)
        SetBlipDisplay(blip, 2)
        SetBlipScale  (blip, 0.9)
        SetBlipColour (blip, 37)
        SetBlipAsShortRange(blip, true)
    
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString('Fruit Trees Field')
        EndTextCommandSetBlipName(blip)

    local blip = AddBlipForCoord(2452.17, 4751.59, 34.3)
    
        SetBlipSprite (blip, 89)
        SetBlipDisplay(blip, 2)
        SetBlipScale  (blip, 0.9)
        SetBlipColour (blip, 37)
        SetBlipAsShortRange(blip, true)
    
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString('Cows')
        EndTextCommandSetBlipName(blip)

    local blip = AddBlipForCoord(441.94, 6457.66, 35.86)
    
        SetBlipSprite (blip, 88)
        SetBlipDisplay(blip, 2)
        SetBlipScale  (blip, 0.9)
        SetBlipColour (blip, 37)
        SetBlipAsShortRange(blip, true)
    
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString('Farm Process')
        EndTextCommandSetBlipName(blip)
		
    local blip = AddBlipForCoord(1469.82, 6550.53, 14.9)
    
        SetBlipSprite (blip, 88)
        SetBlipDisplay(blip, 2)
        SetBlipScale  (blip, 0.9)
        SetBlipColour (blip, 37)
        SetBlipAsShortRange(blip, true)
    
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString('Farm Sell')
        EndTextCommandSetBlipName(blip)
end)

-- Frutas

RegisterNetEvent('mt-farm:client:ApanharMacas', function()
    local quantidade = Config.FruitQuantity
    QBCore.Functions.TriggerCallback('mt-farm:server:VerificarItem', function(HasItem)
        if HasItem then
            QBCore.Functions.Progressbar('pick_apple', 'PICKING APPLES...', 7500, false, true, {
                disableMovement = true,
                disableCarMovement = true,
                disableMouse = false,
                disableCombat = true,
            }, {
                animDict = 'anim@gangops@facility@servers@',
                anim = 'hotwire',
                flags = 16,
            }, {}, {}, function()
                ClearPedTasks(PlayerPedId())
                TriggerServerEvent('mt-farm:server:AddItem', "farm_maca", quantidade)
            end)
        else
            QBCore.Functions.Notify('You dont have a Scisors', 'error', 7500)
        end
    end, 'farm_tesoura')
end)

RegisterNetEvent('mt-farm:client:ApanharLaranjas', function()
    local quantidade = Config.FruitQuantity
    QBCore.Functions.TriggerCallback('mt-farm:server:VerificarItem', function(HasItem)
        if HasItem then
            QBCore.Functions.Progressbar('pick_apple', 'PICKING ORANGES...', 7500, false, true, {
                disableMovement = true,
                disableCarMovement = true,
                disableMouse = false,
                disableCombat = true,
            }, {
                animDict = 'anim@gangops@facility@servers@',
                anim = 'hotwire',
                flags = 16,
            }, {}, {}, function()
                ClearPedTasks(PlayerPedId())
                TriggerServerEvent('mt-farm:server:AddItem', "farm_laranja", quantidade)
            end)
        else
            QBCore.Functions.Notify('You dont have a Scisors', 'error', 7500)
        end
    end, 'farm_tesoura')
end)

RegisterNetEvent('mt-farm:client:ApanharLimao', function()
    local quantidade = Config.FruitQuantity
    QBCore.Functions.TriggerCallback('mt-farm:server:VerificarItem', function(HasItem)
        if HasItem then
            QBCore.Functions.Progressbar('pick_apple', 'PICKING LIMONS...', 7500, false, true, {
                disableMovement = true,
                disableCarMovement = true,
                disableMouse = false,
                disableCombat = true,
            }, {
                animDict = 'anim@gangops@facility@servers@',
                anim = 'hotwire',
                flags = 16,
            }, {}, {}, function()
                ClearPedTasks(PlayerPedId())
                TriggerServerEvent('mt-farm:server:AddItem', "farm_limao", quantidade)
            end)
        else
            QBCore.Functions.Notify('You dont have a Scisors', 'error', 7500)
        end
    end, 'farm_tesoura')
end)

RegisterNetEvent('mt-farm:client:ApanharPeras', function()
    local quantidade = Config.FruitQuantity
    QBCore.Functions.TriggerCallback('mt-farm:server:VerificarItem', function(HasItem)
        if HasItem then
            QBCore.Functions.Progressbar('pick_apple', 'PICKING PEARS...', 7500, false, true, {
                disableMovement = true,
                disableCarMovement = true,
                disableMouse = false,
                disableCombat = true,
            }, {
                animDict = 'anim@gangops@facility@servers@',
                anim = 'hotwire',
                flags = 16,
            }, {}, {}, function()
                ClearPedTasks(PlayerPedId())
                TriggerServerEvent('mt-farm:server:AddItem', "farm_pera", quantidade)
            end)
        else
            QBCore.Functions.Notify('You dont have a Scisors', 'error', 7500)
        end
    end, 'farm_tesoura')
end)

RegisterNetEvent('mt-farm:client:ApanharPessegos', function()
    local quantidade = Config.FruitQuantity
    QBCore.Functions.TriggerCallback('mt-farm:server:VerificarItem', function(HasItem)
        if HasItem then
            QBCore.Functions.Progressbar('pick_apple', 'PICKING PEACHES...', 7500, false, true, {
                disableMovement = true,
                disableCarMovement = true,
                disableMouse = false,
                disableCombat = true,
            }, {
                animDict = 'anim@gangops@facility@servers@',
                anim = 'hotwire',
                flags = 16,
            }, {}, {}, function()
                ClearPedTasks(PlayerPedId())
                TriggerServerEvent('mt-farm:server:AddItem', "farm_pessego", quantidade)
            end)
        else
            QBCore.Functions.Notify('You dont have a Scisors', 'error', 7500)
        end
    end, 'farm_tesoura')
end)

RegisterNetEvent('mt-farm:client:ApanharMangas', function()
    local quantidade = Config.FruitQuantity
    QBCore.Functions.TriggerCallback('mt-farm:server:VerificarItem', function(HasItem)
        if HasItem then
            QBCore.Functions.Progressbar('pick_apple', 'PICKING MANGOS...', 7500, false, true, {
                disableMovement = true,
                disableCarMovement = true,
                disableMouse = false,
                disableCombat = true,
            }, {
                animDict = 'anim@gangops@facility@servers@',
                anim = 'hotwire',
                flags = 16,
            }, {}, {}, function()
                ClearPedTasks(PlayerPedId())
                TriggerServerEvent('mt-farm:server:AddItem', "farm_manga", quantidade)
            end)
        else
            QBCore.Functions.Notify('You dont have a Scisors', 'error', 7500)
        end
    end, 'farm_tesoura')
end)

-- Processo

RegisterNetEvent('mt-farm:client:MenuProcesso', function()
    exports['qb-menu']:openMenu({
        {
            header = "Aliments Process",
            isMenuHeader = true,
        },
        {
            header = "< Close Menu",
            params = {
                event = "qb-menu:closeMenu",
            }
        },
        {
            header = "Make Tomato Juice",
            txt = "",
            params = {
                event = "mt-farm:client:ProcessarTomate",
            }
        },
        {
            header = "Make Flour",
            txt = "",
            params = {
                event = "mt-farm:client:ProcessarTrigo",
            }
        },
        {
            header = "Make Orange Juice",
            txt = "",
            params = {
                event = "mt-farm:client:ProcessarLaranjas",
            }
        },
        {
            header = "Make Peach Juice",
            txt = "",
            params = {
                event = "mt-farm:client:ProcessarPessego",
            }
        },
        {
            header = "Make Apple Juice",
            txt = "",
            params = {
                event = "mt-farm:client:ProcessarMaca",
            }
        },
        {
            header = "Make Mango Juice",
            txt = "",
            params = {
                event = "mt-farm:client:ProcessarManga",
            }
        },
        {
            header = "Make Pear Juice",
            txt = "",
            params = {
                event = "mt-farm:client:ProcessarPera",
            }
        },
        {
            header = "Make Limon Juice",
            txt = "",
            params = {
                event = "mt-farm:client:ProcessarLimao",
            }
        },
    })
end)

CreateThread(function()
    RequestModel(`a_m_m_farmer_01`)
      while not HasModelLoaded(`a_m_m_farmer_01`) do
      Wait(1)
    end
      farmProcess = CreatePed(2, `a_m_m_farmer_01`, Config.ProcessPed, false, false)
      SetPedFleeAttributes(farmProcess, 0, 0)
      SetPedDiesWhenInjured(farmProcess, false)
      TaskStartScenarioInPlace(farmProcess, "missheistdockssetup1clipboard@base", 0, true)
      SetPedKeepTask(farmProcess, true)
      SetBlockingOfNonTemporaryEvents(farmProcess, true)
      SetEntityInvincible(farmProcess, true)
      FreezeEntityPosition(farmProcess, true)

    exports['qb-target']:AddBoxZone("farmProcess", Config.ProcessPedTarget, 1, 1, {
        name="farmProcess",
        heading=0,
        debugpoly = false,
    }, {
        options = {
            {
                event = "mt-farm:client:MenuProcesso",
                icon = "fas fa-farm",
                label = "Talk to farmer",
            },
        },
        distance = 1.5
    })
end)

RegisterNetEvent('mt-farm:client:ProcessarTomate', function()
    TriggerEvent('animations:client:EmoteCommandStart', {"clipboard2"})
    QBCore.Functions.Progressbar('name_here', 'MAKING TOMATO JUICE...', 5000, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {}, {}, {}, function()
        TriggerEvent('animations:client:EmoteCommandStart', {"c"})
        TriggerServerEvent('mt-farm:server:ProcessarTomate')
    end)
end)

RegisterNetEvent('mt-farm:client:ProcessarTrigo', function()
    TriggerEvent('animations:client:EmoteCommandStart', {"clipboard2"})
    QBCore.Functions.Progressbar('name_here', 'MAKING WHEAT FLOUR...', 5000, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {}, {}, {}, function()
        TriggerEvent('animations:client:EmoteCommandStart', {"c"})
        TriggerServerEvent('mt-farm:server:ProcessarTrigo')
    end)
end)

RegisterNetEvent('mt-farm:client:ProcessarLaranjas', function()
    TriggerEvent('animations:client:EmoteCommandStart', {"clipboard2"})
    QBCore.Functions.Progressbar('name_here', 'MAKING ORANGE JUICE...', 5000, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {}, {}, {}, function()
        TriggerEvent('animations:client:EmoteCommandStart', {"c"})
        TriggerServerEvent('mt-farm:server:ProcessarLaranjas')
    end)
end)

RegisterNetEvent('mt-farm:client:ProcessarPessego', function()
    TriggerEvent('animations:client:EmoteCommandStart', {"clipboard2"})
    QBCore.Functions.Progressbar('name_here', 'MAKING PEACH JUICE...', 5000, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {}, {}, {}, function()
        TriggerEvent('animations:client:EmoteCommandStart', {"c"})
        TriggerServerEvent('mt-farm:server:ProcessarPessego')
    end)
end)

RegisterNetEvent('mt-farm:client:ProcessarMaca', function()
    TriggerEvent('animations:client:EmoteCommandStart', {"clipboard2"})
    QBCore.Functions.Progressbar('name_here', 'MAKING APPLE JUICE...', 5000, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {}, {}, {}, function()
        TriggerEvent('animations:client:EmoteCommandStart', {"c"})
        TriggerServerEvent('mt-farm:server:ProcessarMaca')
    end)
end)

RegisterNetEvent('mt-farm:client:ProcessarManga', function()
    TriggerEvent('animations:client:EmoteCommandStart', {"clipboard2"})
    QBCore.Functions.Progressbar('name_here', 'MAKING MANGO JUICE...', 5000, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {}, {}, {}, function()
        TriggerEvent('animations:client:EmoteCommandStart', {"c"})
        TriggerServerEvent('mt-farm:server:ProcessarManga')
    end)
end)

RegisterNetEvent('mt-farm:client:ProcessarPera', function()
    TriggerEvent('animations:client:EmoteCommandStart', {"clipboard2"})
    QBCore.Functions.Progressbar('name_here', 'MAKING PEAR JUICE...', 5000, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {}, {}, {}, function()
        TriggerEvent('animations:client:EmoteCommandStart', {"c"})
        TriggerServerEvent('mt-farm:server:ProcessarPera')
    end)
end)

RegisterNetEvent('mt-farm:client:ProcessarLimao', function()
    TriggerEvent('animations:client:EmoteCommandStart', {"clipboard2"})
    QBCore.Functions.Progressbar('name_here', 'MAKING LIMON JUICE...', 5000, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {}, {}, {}, function()
        TriggerEvent('animations:client:EmoteCommandStart', {"c"})
        TriggerServerEvent('mt-farm:server:ProcessarLimao')
    end)
end)

-- Venda

RegisterNetEvent('mt-farm:client:VenderTudo', function()
    TriggerEvent('animations:client:EmoteCommandStart', {"clipboard2"})
    QBCore.Functions.Progressbar('name_here', 'MAKING A DEAL...', 5000, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {}, {}, {}, function()
        TriggerEvent('animations:client:EmoteCommandStart', {"c"})
    TriggerServerEvent('mt-farm:server:venderTudo')
    end)
end)

CreateThread(function()
    RequestModel(`a_m_m_farmer_01`)
      while not HasModelLoaded(`a_m_m_farmer_01`) do
      Wait(1)
    end
      farmSell = CreatePed(2, `a_m_m_farmer_01`, Config.SellPed, false, false)
      SetPedFleeAttributes(farmSell, 0, 0)
      SetPedDiesWhenInjured(farmSell, false)
      TaskStartScenarioInPlace(farmSell, "missheistdockssetup1clipboard@base", 0, true)
      SetPedKeepTask(farmSell, true)
      SetBlockingOfNonTemporaryEvents(farmSell, true)
      SetEntityInvincible(farmSell, true)
      FreezeEntityPosition(farmSell, true)

    exports['qb-target']:AddBoxZone("farmSell", Config.SellPedTarget, 1, 1, {
        name="farmSell",
        heading=0,
        debugpoly = false,
    }, {
        options = {
            {
                event = "mt-farm:client:VenderTudo",
                icon = "fas fa-farm",
                label = "Talk to farmer",
            },
        },
        distance = 1.5
    })
end)
