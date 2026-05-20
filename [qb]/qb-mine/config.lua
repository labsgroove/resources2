Config = {
    pricexd = {
        -- ['item'] = {min, max} --
        steel = math.random(100, 400),
        iron = math.random(100, 600),
        copper = math.random(300, 600),
        diamond = math.random(500, 900)
    },
    ChanceToGetItem = 20, -- if math.random(0, 100) <= ChanceToGetItem then give item
    Items = {'steel','steel','steel','steel','iron', 'iron', 'iron', 'copper', 'copper', 'diamond'},
    Sell = vector3(-97.12, -1013.8, 26.3),
    Objects = {
        ['pickaxe'] = 'prop_tool_pickaxe',
    },
    MiningPositions = {
        {coords = vector3(-561.57, 1888.66, 123.22), heading = 20.71},
        {coords = vector3(-588.83, 1895.67, 123.22), heading = 221.68},
        {coords = vector3(-543.69, 1975.56, 127.02), heading = 106.01},
        {coords = vector3(-477.84, 1989.5, 123.91), heading = 9.85},
        {coords = vector3(-426.33, 2064.88, 120.53), heading = 18.8}
    },
}

Strings = {
    ['press_mine'] = 'Press ~INPUT_CONTEXT~ to mine.',
    ['mining_info'] = 'Press ~INPUT_ATTACK~ to chop, ~INPUT_FRONTEND_RRIGHT~ to stop.',
    ['you_sold'] = 'Sold verkocht %sx %s for %s',
    ['e_sell'] = 'Press ~INPUT_CONTEXT~ to sell materials from the mine.',
    ['someone_close'] = 'Citizen too close!',
    ['mining'] = 'Mining place',
    ['sell_mine'] = 'Sellpoint Mining'
}