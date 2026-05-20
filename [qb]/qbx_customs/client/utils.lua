local config = require 'config.client'
local QBCore = exports['qb-core']:GetCoreObject()

local function NotifyClient(message, typeOrPosition, duration, description, position, style, icon, iconColor)
    -- QBCore.Functions.Notify(message, type) is common; ox_lib style may include more params.
    if QBCore and QBCore.Functions and QBCore.Functions.Notify then
        -- If typeOrPosition looks like a type (string 'error'/'success'), use it; otherwise default to 'success'
        local notifyType = (typeOrPosition == 'error' or typeOrPosition == 'success') and typeOrPosition or 'success'
        QBCore.Functions.Notify(message, notifyType, duration)
        return
    end

    -- Fallback to triggering the event many resources use
    TriggerEvent('QBCore:Notify', message, typeOrPosition or 'success')
end

-- Safe audio helper: prefer qbx.playAudio if available, otherwise fall back to native PlaySoundFrontend
local function PlayAudio(opts)
    if type(opts) ~= 'table' then opts = {} end
    local audioName = opts.audioName or opts.name or 'PICK_UP'
    local audioRef = opts.audioRef or 'HUD_FRONTEND_DEFAULT_SOUNDSET'

    if qbx and type(qbx.playAudio) == 'function' then
        qbx.playAudio({ audioName = audioName, audioRef = audioRef })
        return
    end

    -- Fallback native sound
    -- PlaySoundFrontend(soundId, soundName, soundset, p3)
    -- We'll call PlaySoundFrontend with the audio name and ref where supported.
    if type(PlaySoundFrontend) == 'function' then
        PlaySoundFrontend(-1, audioName, audioRef, true)
    end
end

-- Export helpers for other modules in this resource


---@param vehicle number
---@param modType number
---@param modValue number
---@return string
function GetModLabel (vehicle, modType, modValue)
    if config.modLabels[modType] then
        for _, mod in ipairs(config.modLabels[modType]) do
            if mod.id == modValue then return mod.label end
        end
    end

    if modValue == -1 then return locale('menus.general.stock') end

    local label = GetModTextLabel(vehicle, modType, modValue)
    return (not label or label == '') and tostring(modValue) or GetLabelText(label)
end

---@param duplicate boolean
---@param mod 'repair' | 'cosmetic' | 'colors' | 11 | 12 | 13 | 15 | 18
---@param props NotifyProps?
---@param level number?
function InstallMod(duplicate, mod, props, level)
    if duplicate then
        NotifyClient(locale('notifications.error.alreadyInstalled'), 'error')
        return false
    end
    
    local success = openedWithExports or lib.callback.await('qbx_customs:server:pay', false, mod, level)
    if success then
        NotifyClient(
            props?.title or locale('notifications.props.installTitle'),
            props?.position or 'top',
            props?.duration,
            props?.description,
            props?.position or 'top',
            props?.style,
            props?.icon or 'fa-solid fa-wrench',
            props?.iconColor
        )
        PlayAudio({ audioName = 'PICK_UP', audioRef = 'HUD_FRONTEND_DEFAULT_SOUNDSET' })
        return true
    end

    NotifyClient(locale('notifications.error.money'), 'error')
    return false
end

-- Return helpers for other modules
return {
    NotifyClient = NotifyClient,
    PlayAudio = PlayAudio,
}