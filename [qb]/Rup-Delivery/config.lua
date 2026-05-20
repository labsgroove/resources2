Config = {}

Config.Debug = false

Config.Framework = 'qb' --[[ qb, esx, nd, qbx ]]

Config.DropOffs = {
    [1] = vector3(-1799.4910, 3087.8162, 32.8418),
    [2] = vector3(639.7883, 2772.3320, 42.0405),
    [3] = vector3(2051.6499, 3174.9551, 45.1690),
    [4] = vector3(2601.1506, 2803.8853, 33.8218),
    [5] = vector3(2854.4915, 1502.0927, 24.7243),
    [6] = vector3(2549.2966, 381.3326, 108.6229),
    [7] = vector3(2503.6003, -440.1854, 92.9929),
    [8] = vector3(707.1675, -963.1467, 30.4083),
    [9] = vector3(-592.3634, -1773.0146, 22.8019),
    [10] = vector3(143.0279, -3218.9175, 5.8576),
    -- Add more drop-off positions as needed
}

Config.Spawns = {
    [1] = vector4(183.5798, 6403.5063, 31.2941, 294.9047),
    [2] = vector4(1590.6219, -1712.9958, 88.1625, 106.2169),
    [3] = vector4(1201.3616, -3188.4199, 6.0280, 178.6679),
    [4] = vector4(-452.4424, -2792.4839, 6.0004, 43.2546)
    -- Where you want the truck to spawn
}

Config.JobLoc = {
    [1] = {v = vector3(185.6476, 6380.3428, 32.3400), h = 133.8708, veh = "trailers2"},
    [2] = {v = vector3(1586.2980, -1692.3906, 88.1224), h = 9.1194, veh = "trailers2"},
    [3] = {v = vector3(1184.2034, -3174.4019, 7.1061), h = 262.6497, veh = "trailers2"},
    [4] = {v = vector3(-424.23, -2789.84, 6.52), h = 134.05, veh = "trailers2"}
    -- Where the Job locactions are
}

Config.Payouts = {
    [1] = function()
        return math.random(5000, 7500)
    end,
    [2] = function()
        return math.random(8000, 12000)
    end,
    [3] = function()
        return math.random(8000, 20000)
    end,
    [4] = function()
        return math.random(12000, 20000)
    end,
    [5] = function()
        return math.random(20000, 50000)
    end,
    [6] = function()
        return math.random(20000, 50000)
    end,
    [7] = function()
        return math.random(20000, 50000)
    end,
    [8] = function()
        return math.random(20000, 50000)
    end,
    [9] = function()
        return math.random(20000, 50000)
    end,
    [10] = function()
        return math.random(200000, 500000)
    end
    -- Add more payouts as needed
}