----<<<<<----  https://perfect.tebex.io/ ------>>>>>--------
----<<<<<----  Weed Heist  - QBCore Version ------>>>>>--------


---- If you have any problem contact via discord.
    ---- Discord - https://discord.gg/5rnQzbcWXx

Config = {}

Config['Rob'] = {

    ['Timenextrob'] = 3600,
    ['Policejobname'] = 'police',

    ['Startpedmodel'] = 'skeleton',
    ['StartLocCfg'] = vector3(-220.3237, -57.2509, 2108.9800 ),
    ['StartLocHeadingCfg'] =  359.2328,
    ['PDTruck'] = 'havok',
    ['TruckSpawnCfg'] = vector3(-176.0647, -90.5662, 2110.5618 ),
    ['TruckSpawnHeadingCfg'] = 5.7968,

    ['GuardCfg'] = { ---- https://docs.fivem.net/docs/game-references/ped-models

        {vector = vector3(-203.9230, -75.1263, 2109.9780), w = 90.0017, pedmodel = 's_m_y_swat_01', weapon = 'weapon_heavysniper_mk2'},
        {vector = vector3(-186.6920, -92.3802, 2117.4971), w = 42.5808, pedmodel = 's_m_y_swat_01', weapon = 'weapon_heavysniper_mk2'},
        {vector = vector3(-191.7304, -68.8244, 2109.9788), w =  177.1001, pedmodel = 's_m_y_swat_01' , weapon = 'weapon_specialcarbine_mk2'},
        {vector = vector3(-206.1078, -72.8231, 2109.9797), w =  319.2581, pedmodel = 's_m_y_swat_01' , weapon = 'weapon_assaultrifle'},
        {vector = vector3(-207.7358, -56.4999, 2109.9783), w = 174.1952, pedmodel = 's_m_y_swat_01' , weapon = 'weapon_assaultrifle'},
        {vector = vector3(-219.6740, -107.1496, 2109.9788), w = 356.2475, pedmodel = 's_m_y_swat_01' , weapon = 'weapon_heavysniper_mk2'},
        {vector = vector3(-200.5252, -101.0036, 2109.9800), w = 265.5893, pedmodel = 's_m_y_swat_01' , weapon = 'weapon_revolver_mk2'},
        {vector = vector3(-188.0246, -89.1162, 2109.9800), w = 85.7876, pedmodel = 's_m_y_swat_01' , weapon = 'weapon_specialcarbine_mk2'},
        {vector = vector3(-201.3321, -79.4560, 2109.9773), w = 228.4972, pedmodel = 's_m_y_swat_01' , weapon = 'weapon_assaultrifle'},
        {vector = vector3(-188.0670, -100.3989, 2109.9797), w = 358.3013, pedmodel = 's_m_y_swat_01' , weapon = 'weapon_pumpshotgun_mk2'},
        {vector = vector3(-172.9377, -101.2147, 2109.9790), w = 6.6208, pedmodel = 's_m_y_swat_01' , weapon = 'weapon_revolver_mk2'},
        {vector = vector3(-185.9963, -89.1568, 2109.9783), w = 262.2145, pedmodel = 's_m_y_swat_01', weapon = 'weapon_combatmg_mk2'},
        {vector = vector3(-174.2356, -49.9027, 2109.9766), w = 133.3743, pedmodel = 's_m_y_swat_01', weapon = 'weapon_heavysniper_mk2'},

        --- If you need more guards you can add here.

    },
    ['DeliverLocCfg'] = { 

        {vector = vector3(-1112.7396, -2884.0371, 13.9460), sellprice = 1000000, item = 'drill', itemamount = 5},
        {vector = vector3(3066.3589, -4615.9517, 15.2614), sellprice = 700000, item = 'security_card_02', itemamount = 5},
        {vector = vector3(-1927.4611, 3124.3569, 32.8103), sellprice = 800000, item = 'security_card_01', itemamount = 5},
        {vector = vector3(1769.6473, 3238.2688, 42.1648), sellprice = 900000, item = 'advancedlockpick', itemamount = 5},

        --- If you need more delivery locations you can add here. delivery locations are selecting ramdomly.

    },
}