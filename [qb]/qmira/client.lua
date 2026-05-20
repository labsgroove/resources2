local crosshairEnabled = true
local infiniteAmmo = true

-- Comando pra ativar/desativar a mira
RegisterCommand("crosshair", function()
    crosshairEnabled = not crosshairEnabled
    local status = crosshairEnabled and "ativada ✅" or "desativada ❌"
    print("🔫 Mira personalizada " .. status)
end)

-- Comando pra ativar/desativar a munição infinita
RegisterCommand("infammo", function()
    infiniteAmmo = not infiniteAmmo
    local status = infiniteAmmo and "ativada ♾️" or "desativada 🚫"
    print("💥 Munição infinita " .. status)
end)

Citizen.CreateThread(function()
    while true do
        Wait(0)
        local ped = PlayerPedId()

        -- Mostrar mira se estiver mirando e habilitada
        if crosshairEnabled and IsPlayerFreeAiming(PlayerId()) then
            local x, y = 0.5, 0.5
            DrawRect(x, y, 0.001, 0.019, 0, 255, 0, 200) -- verde
            DrawRect(x, y, 0.01, 0.001, 0, 255, 0, 200)
        end

        -- Forçar munição infinita se ativada
        if infiniteAmmo then
            local weapon = GetSelectedPedWeapon(ped)
            if weapon ~= `WEAPON_UNARMED` then
                local ammo = GetAmmoInPedWeapon(ped, weapon)
                if ammo < 9999 then
                    SetPedAmmo(ped, weapon, 9999)
                end
            end
        end
    end
end)
