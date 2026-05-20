Config = {}

Config.Debug = false

Config.Framework = 'qb' --[[ qb, esx, nd, qbx ]]

Config.DropOffs = {
    [1] = vector3(-1621.6339, -3152.7429, 13.9918),
    [2] = vector3(-1832.0756, 3020.5535, 32.8104),
    [3] = vector3(1721.5249, 3319.6382, 41.2235),
    [4] = vector3(4446.9614, -4443.5151, 7.2368),
    [5] = vector3(3093.1624, -4695.7065, 27.2569)
  -- Add more drop-off positions as needed
}

Config.Spawns = {
    [1] = vector4(2134.1648, 4782.3218, 40.9703, 23.0907)
    -- Where you want the truck to spawn
}

Config.JobLoc = {
    [1] = {v = vector3(2122.5925, 4784.9780, 40.9703 ), h = 116.5612, veh = "sr22"}
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