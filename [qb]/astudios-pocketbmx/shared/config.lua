Config = {}
Config.Debug = false -- True / False for Debug System

-- Notifications
Config.NotificationType = { -- 'qbcore' / 'astudios'
    server = 'astudios',
    client = 'astudios' 
}

-- Settings
Config.BikeItem = 'bmx'

Config.Language = {
    Progressbar = {
        ['placing'] = 'Montando bike',
        ['removing'] = 'Guardando bike',
    },
    Error = {
        ['too_far_or_in_use'] = 'Muito longe da bike ou já em uso',
    }
}
