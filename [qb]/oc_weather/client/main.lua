RegisterCommand('changeweather', function()
    exports['qb-menu']:openMenu({
        {
            header = 'Menu do Tempo',
            icon = 'fa-solid fa-cloud',
            isMenuHeader = true, -- Set to true to make a nonclickable title
        },
        {
            header = 'Mudar hora',
            txt = 'Opens Time Options',
            icon = 'fa-solid fa-clock',
            -- disabled = false, -- optional, non-clickable and grey scale
            -- hidden = true, -- optional, hides the button completely
            params = {
                -- isServer = false, -- optional, specify event type
                event = 'oc_weather:time',
                args = {
                    number = 2,
                }
            }
        },
        {
            header = 'Mudar clima',
            txt = 'Opens Weather Options',
            icon = 'fa-solid fa-cloud',
            -- disabled = false, -- optional, non-clickable and grey scale
            -- hidden = true, -- optional, hides the button completely
            params = {
                -- isServer = false, -- optional, specify event type
                event = 'oc_weather:weather',
                args = {
                    number = 2,
                }
            }
        },
    })
end)

RegisterNetEvent('oc_weather:time', function(data)
    local number = data.number
    exports['qb-menu']:openMenu({
        {
            header = 'Voltar',
            icon = 'fa-solid fa-backward',
            params = {
                event = 'oc_weather:return',
                args = {}
            }
        },
        {
            header = 'Dia',
            icon = 'fa-solid fa-sun',
            params = {
                event = 'oc_weather:day',
                args = {}
            }
        },
        {
            header = 'Noite',
            icon = 'fa-solid fa-moon',
            params = {
                event = 'oc_weather:night',
                args = {}
            }
        }
    })
end)

RegisterNetEvent('oc_weather:weather', function(data)
    local number = data.number
    exports['qb-menu']:openMenu({
        {
            header = 'Voltar',
            icon = 'fa-solid fa-backward',
            params = {
                event = 'oc_weather:return',
                args = {}
            }
        },
        {
            header = 'Sol',
            icon = 'fa-solid fa-sun',
            params = {
                event = 'oc_weather:sun',
                args = {}
            }
        },
        {
            header = 'Nevoeiro',
            icon = 'fa-solid fa-smog',
            params = {
                event = 'oc_weather:fog',
                args = {}
            }
        },
        {
            header = 'Chuva',
            icon = 'fa-solid fa-cloud-rain',
            params = {
                event = 'oc_weather:rain',
                args = {}
            }
        },
        {
            header = 'Neve',
            icon = 'fa-solid fa-snowflake',
            params = {
                event = 'oc_weather:snow',
                args = {}
            }
        },
        {
            header = 'Halloween',
            icon = 'fa-solid fa-ghost',
            params = {
                event = 'oc_weather:halloween',
                args = {}
            }
        },
    })
end)

RegisterNetEvent('oc_weather:return', function()
    ExecuteCommand('changeweather')
end)

RegisterNetEvent('oc_weather:day', function()
    TriggerEvent('qb-weathersync:client:DisableSync')
    Citizen.Wait(1000)
    NetworkOverrideClockTime(10, 10, 10)
end)

RegisterNetEvent('oc_weather:night', function()
    TriggerEvent('qb-weathersync:client:DisableSync')
    Citizen.Wait(1000)
    NetworkOverrideClockTime(22, 10, 10)
end)

RegisterNetEvent('oc_weather:sun', function()
    TriggerEvent('qb-weathersync:client:DisableSync')
    SetWeatherOwnedByNetwork(false)
    SetWeatherTypeOvertimePersist('EXTRASUNNY', 1.0)
end)

RegisterNetEvent('oc_weather:fog', function()
    TriggerEvent('qb-weathersync:client:DisableSync')
    SetWeatherOwnedByNetwork(false)
    SetWeatherTypeOvertimePersist('FOGGY', 1.0)
end)

RegisterNetEvent('oc_weather:rain', function()
    TriggerEvent('qb-weathersync:client:DisableSync')
    SetWeatherOwnedByNetwork(false)
    SetWeatherTypeOvertimePersist('THUNDER', 1.0)
end)

RegisterNetEvent('oc_weather:snow', function()
    TriggerEvent('qb-weathersync:client:DisableSync')
    SetWeatherOwnedByNetwork(false)
    SetWeatherTypeOvertimePersist('XMAS', 1.0)
end)

RegisterNetEvent('oc_weather:halloween', function()
    TriggerEvent('qb-weathersync:client:DisableSync')
    SetWeatherOwnedByNetwork(false)
    SetWeatherTypeOvertimePersist('HALLOWEEN', 1.0)
end)