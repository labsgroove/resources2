----<<<<<----  https://perfect.tebex.io/ ------>>>>>--------
----<<<<<----  Titan Heist  - QBCore Version ------>>>>>--------


---- If you have any problem contact via discord.
    ---- Discord - https://discord.gg/5rnQzbcWXx

Config = {}

Config['Rob'] = {

    ['Timenextrob'] = 3600,
    ['Policejobname'] = 'police',

    ['Startpedmodel'] = 'ig_lestercrest_2',
    ['StartLocCfg'] = vector3(1048.2222, -723.6053, 56.2151 ),
    ['StartLocHeadingCfg'] =  230.4873,
    ['PDTruck'] = 'titan',
    ['TruckSpawnCfg'] = vector3(-1271.9978, -3382.6240, 14.7804),
    ['TruckSpawnHeadingCfg'] = 331.0067,

    ['GuardCfg'] = { ---- https://docs.fivem.net/docs/game-references/ped-models

        {vector = vector3(-1236.0560, -3387.3386, 17.5089), w = 38.9094, pedmodel = 's_m_y_swat_01', weapon = 'weapon_heavysniper_mk2'},
        {vector = vector3(-1230.4569, -3382.9805, 24.2680), w = 58.4822, pedmodel = 's_m_y_swat_01', weapon = 'weapon_heavysniper_mk2'},
        {vector = vector3(-1268.5657, -3428.2520, 24.2680), w =  337.4680, pedmodel = 's_m_y_swat_01' , weapon = 'weapon_specialcarbine_mk2'},
        {vector = vector3(-1307.1315, -3386.9167, 24.2768), w =  311.2857, pedmodel = 's_m_y_swat_01' , weapon = 'weapon_assaultrifle'},
        {vector = vector3(-1292.9764, -3347.2026, 24.2680), w = 230.1468, pedmodel = 's_m_y_swat_01' , weapon = 'weapon_assaultrifle'},
        {vector = vector3(-1307.5353, -3392.7610, 16.9977), w = 316.6604, pedmodel = 's_m_y_swat_01' , weapon = 'weapon_heavysniper_mk2'},
        {vector = vector3(-1290.5920, -3417.5107, 13.9402), w = 305.5991, pedmodel = 's_m_y_swat_01' , weapon = 'weapon_revolver_mk2'},
        {vector = vector3(-1258.2050, -3413.2214, 13.9402), w = 27.5546, pedmodel = 's_m_y_swat_01' , weapon = 'weapon_specialcarbine_mk2'},
        {vector = vector3(-1290.3134, -3346.0164, 13.9450), w = 189.6918, pedmodel = 's_m_y_swat_01' , weapon = 'weapon_assaultrifle'},
        {vector = vector3(-1279.3319, -3336.6814, 13.9451), w = 304.2369, pedmodel = 's_m_y_swat_01' , weapon = 'weapon_pumpshotgun_mk2'},
        {vector = vector3(-1227.1394, -3378.8069, 13.9451), w = 43.1714, pedmodel = 's_m_y_swat_01' , weapon = 'weapon_revolver_mk2'},
        {vector = vector3(-1277.6158, -3392.1331, 13.9402), w = 324.2759, pedmodel = 's_m_y_swat_01', weapon = 'weapon_combatmg_mk2'},
        {vector = vector3(-1306.0620, -3405.2349, 13.9402), w = 336.5882, pedmodel = 's_m_y_swat_01', weapon = 'weapon_heavysniper_mk2'},

        --- If you need more guards you can add here.

    },
    ['DeliverLocCfg'] = { 

        {vector = vector3(-2185.0769, 3175.6980, 33.6481), sellprice = 1000000, item = 'drill', itemamount = 5},
        {vector = vector3(-1925.7052, 3024.3220, 33.6525), sellprice = 700000, item = 'security_card_02', itemamount = 5},
        {vector = vector3(1755.9399, 3264.2651, 42.1748), sellprice = 800000, item = 'security_card_01', itemamount = 5},
        {vector = vector3(1075.2438, 3042.7693, 42.0145), sellprice = 900000, item = 'advancedlockpick', itemamount = 5},

        --- If you need more delivery locations you can add here. delivery locations are selecting ramdomly.

    },
}