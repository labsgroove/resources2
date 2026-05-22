local QBCore = exports['qb-core']:GetCoreObject()

local launchedVehicles = {}

RegisterCommand('setlauncher', function()

    local ped = PlayerPedId()
    local coords = GetEntityCoords(ped)

    table.insert(Config.Launchers,{
        coords = coords
    })

    TriggerEvent('QBCore:Notify',
        'Área lançadora criada!',
        'success'
    )

end)

CreateThread(function()

    while true do

        Wait(100)

        local playerCoords = GetEntityCoords(PlayerPedId())

        for _,launcher in pairs(Config.Launchers) do

            local vehicles = GetGamePool('CVehicle')

            for _,veh in pairs(vehicles) do

                if DoesEntityExist(veh) then

                    local vehCoords = GetEntityCoords(veh)
                    local distance = #(vehCoords - launcher.coords)

                    if distance < Config.Radius then

                        local driver = GetPedInVehicleSeat(veh,-1)

                        -- apenas NPC
                        if driver ~= 0 and not IsPedAPlayer(driver) then

                            local netId = VehToNet(veh)

                            if not launchedVehicles[netId] then

                                launchedVehicles[netId] = true

                                LaunchVehicle(veh)

                                SetTimeout(
                                    Config.Cooldown,
                                    function()
                                        launchedVehicles[netId] = nil
                                    end
                                )

                            end
                        end
                    end
                end
            end
        end
    end
end)

function LaunchVehicle(vehicle)

    local forward = GetEntityForwardVector(vehicle)

    local xForce = forward.x * Config.LaunchForce
    local yForce = forward.y * Config.LaunchForce

    ApplyForceToEntity(
        vehicle,
        1,
        xForce,
        yForce,
        Config.UpForce,
        7.0,
        0.0,
        0.0,
        false,
        true,
        true,
        false,
        true
    )

    SetVehicleForwardSpeed(vehicle,110.0)

    UseParticleFxAssetNextCall("core")

    StartParticleFxNonLoopedAtCoord(
        "eject_stungun",
        GetEntityCoords(vehicle),
        0.0,
        0.0,
        0.0,
        1.5,
        false,
        false,
        false
    )
end