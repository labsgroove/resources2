----<<<<<----  https://perfect.tebex.io/ ------>>>>>--------
----<<<<<----  Weed Heist  - QBCore Version ------>>>>>--------


---- If you have any problem contact via discord.
    ---- Discord - https://discord.gg/5rnQzbcWXx

Config = {}

Config['Rob'] = {

    ['Timenextrob'] = 7200,
    ['Policejobname'] = 'police',

    ['Startpedmodel'] = 'a_f_y_topless_01',
    ['StartLocCfg'] = vector3(125.4415, -1286.2251, 28.2694 ),
    ['StartLocHeadingCfg'] = 205.1906,
    ['PDTruck'] = 'tiger',
    ['TruckSpawnCfg'] = vector3(3009.1738, 2682.1707, 75.6093 ),
    ['TruckSpawnHeadingCfg'] = 40.1340,

    ['GuardCfg'] = { ---- https://docs.fivem.net/docs/game-references/ped-models

        {vector = vector3(3003.6562, 2684.5554, 75.0628), w = 38.2825, pedmodel = 'g_m_y_mexgoon_02', weapon = 'weapon_combatmg_mk2'},
        {vector = vector3(3004.0295, 2696.9214, 81.3335), w = 222.6090, pedmodel = 'g_m_y_mexgoon_01', weapon = 'weapon_heavysniper_mk2'},
        {vector = vector3(2996.9263, 2691.4785, 81.3272), w = 223.4802, pedmodel = 'g_m_y_mexgoon_03' , weapon = 'weapon_specialcarbine_mk2'},
        {vector = vector3(2990.1460, 2685.8691, 81.3914), w = 227.8816, pedmodel = 'g_m_y_pologoon_01' , weapon = 'weapon_assaultrifle'},
        {vector = vector3(2980.7048, 2676.6702, 81.6756), w = 237.1253, pedmodel = 'g_m_y_pologoon_02' , weapon = 'weapon_assaultrifle'},
        {vector = vector3(2995.4856, 2691.6897, 75.4098), w = 222.3246, pedmodel = 'g_m_y_salvaboss_01' , weapon = 'weapon_pumpshotgun_mk2'},
        {vector = vector3(3007.8069, 2700.3555, 74.9009), w = 214.5119, pedmodel = 'g_m_y_salvagoon_01' , weapon = 'weapon_revolver_mk2'},
        {vector = vector3(2988.7878, 2666.8391, 75.3837), w = 33.0365, pedmodel = 'g_m_y_mexgoon_03' , weapon = 'weapon_specialcarbine_mk2'},
        {vector = vector3(2974.5344, 2668.0620, 74.8674), w = 212.2552, pedmodel = 'g_m_y_pologoon_02' , weapon = 'weapon_assaultrifle'},
        {vector = vector3(2964.2029, 2665.0913, 80.5858), w = 173.7407, pedmodel = 'g_m_y_salvaboss_01' , weapon = 'weapon_pumpshotgun_mk2'},
        {vector = vector3(3023.6526, 2707.5220, 74.1683), w = 175.7378, pedmodel = 'g_m_y_salvagoon_01' , weapon = 'weapon_revolver_mk2'},
        {vector = vector3(3030.4624, 2698.5718, 74.0155), w = 357.5818, pedmodel = 'g_m_y_mexgoon_02', weapon = 'weapon_combatmg_mk2'},
        {vector = vector3(3038.8850, 2707.8313, 79.5928), w = 174.2931, pedmodel = 'g_m_y_mexgoon_01', weapon = 'weapon_heavysniper_mk2'},

        --- If you need more guards you can add here.

    },
    ['DeliverLocCfg'] = { 

        {vector = vector3(913.57, -1263.2, 25.57), sellprice = 1000000, item = 'weed_skunk', itemamount = 5},
        {vector = vector3(92.06, 67.35, 73.42), sellprice = 700000, item = 'weed_skunk', itemamount = 10},
        {vector = vector3(764.13, 4198.04, 41.62), sellprice = 800000, item = 'weed_skunk', itemamount = 6},
        {vector = vector3(2434.86, 4987.95, 45.99), sellprice = 900000, item = 'weed_skunk', itemamount = 4},

        --- If you need more delivery locations you can add here. delivery locations are selecting ramdomly.

    },
}