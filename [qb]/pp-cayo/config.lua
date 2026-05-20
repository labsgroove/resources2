----<<<<<----  https://perfect.tebex.io/ ------>>>>>--------
----<<<<<----  Weed Heist  - QBCore Version ------>>>>>--------


---- If you have any problem contact via discord.
    ---- Discord - https://discord.gg/5rnQzbcWXx

Config = {}

Config['Rob'] = {

    ['Timenextrob'] = 7200,
    ['Policejobname'] = 'vineyard',

    ['Startpedmodel'] = 'slimer',
    ['StartLocCfg'] = vector3(4494.3770, -4525.4766, 3.4124 ),
    ['StartLocHeadingCfg'] = 319.3910,
    ['PDTruck'] = 'sr650fly',
    ['TruckSpawnCfg'] = vector3(5102.9004, -5197.1152, 0.4766 ),
    ['TruckSpawnHeadingCfg'] = 0.6169,

    ['GuardCfg'] = { ---- https://docs.fivem.net/docs/game-references/ped-models

        {vector = vector3(5109.4834, -5191.3853, 2.0350), w = 336.1254, pedmodel = 'g_m_y_mexgoon_02', weapon = 'weapon_combatmg_mk2'},
        {vector = vector3(5117.4819, -5181.8857, 2.3459), w = 359.9998, pedmodel = 'g_m_y_mexgoon_01', weapon = 'weapon_heavysniper_mk2'},
        {vector = vector3(5118.5195, -5202.5024, 2.4898), w = 6.3520, pedmodel = 'g_m_y_mexgoon_03' , weapon = 'weapon_specialcarbine_mk2'},
        {vector = vector3(5087.4961, -5211.2920, 2.1199), w = 303.4197, pedmodel = 'g_m_y_pologoon_01' , weapon = 'weapon_assaultrifle'},
        {vector = vector3(5087.2383, -5152.3970, 2.1174), w = 283.1045, pedmodel = 'g_m_y_pologoon_02' , weapon = 'weapon_assaultrifle'},
        {vector = vector3(5118.4004, -5130.1816, 2.1457), w = 0.7622, pedmodel = 'g_m_y_salvaboss_01' , weapon = 'weapon_pumpshotgun_mk2'},
        {vector = vector3(5108.8970, -5134.8662, 1.9122), w = 188.7730, pedmodel = 'g_m_y_salvagoon_01' , weapon = 'weapon_revolver_mk2'},
        {vector = vector3(5117.2729, -5152.3438, 2.2223), w = 174.1486, pedmodel = 'g_m_y_mexgoon_03' , weapon = 'weapon_specialcarbine_mk2'},
        {vector = vector3(5131.0376, -5140.3521, 2.1506), w = 177.5294, pedmodel = 'g_m_y_pologoon_02' , weapon = 'weapon_assaultrifle'},
        {vector = vector3(5046.5376, -5112.5957, 22.9446), w = 256.8333, pedmodel = 'g_m_y_salvaboss_01' , weapon = 'weapon_pumpshotgun_mk2'},
        {vector = vector3(5075.4712, -5116.3076, 2.2127), w = 285.3302, pedmodel = 'g_m_y_salvagoon_01' , weapon = 'weapon_revolver_mk2'},
        {vector = vector3(5126.7349, -5100.8730, 4.0242), w = 104.5400, pedmodel = 'g_m_y_mexgoon_02', weapon = 'weapon_combatmg_mk2'},
        {vector = vector3(5118.3647, -5118.0015, 2.1366), w = 89.6065, pedmodel = 'g_m_y_mexgoon_01', weapon = 'weapon_heavysniper_mk2'},

        --- If you need more guards you can add here.

    },
    ['DeliverLocCfg'] = { 

        {vector = vector3(526.3110, -3172.9985, 0.5332), sellprice = 1000000, item = 'weed_skunk', itemamount = 5},
        {vector = vector3(32.1264, -2776.7891, 0.9251), sellprice = 700000, item = 'weed_skunk', itemamount = 10},
        {vector = vector3(-131.2386, -2722.6833, 0.2471), sellprice = 800000, item = 'weed_skunk', itemamount = 6},
        {vector = vector3(-555.1340, -2797.0356, 1.0720), sellprice = 900000, item = 'weed_skunk', itemamount = 4},

        --- If you need more delivery locations you can add here. delivery locations are selecting ramdomly.

    },
}