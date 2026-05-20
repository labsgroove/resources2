QBCore = exports['qb-core']:GetCoreObject() -- do not touch


CONFIG = {} -- do not touch

CONFIG['BaseTime'] = math.random(1,2) -- time in minutes the washing machine always takes
--CONFIG['BaseTime'] = 1

CONFIG['TimePerItem'] = math.random(1,2) -- time in minutes each additional item of dirty money adds
--CONFIG['TimePerItem'] = 1

CONFIG['PoliceIncrease'] = 0.5 -- percentage to increase per officer around

CONFIG['Machines'] = {
	{name="Lavagem1", cost="5", perc=0.6, vec=vector3(-1367.4216, -625.4169, 30.3194), available=true, finished=false, player=0, worth=0, lastsound=0},
	{name="Lavagem2", cost="5", perc=0.6, vec=vector3(978.8420, -92.0958, 74.8451), available=true, finished=false, player=0, worth=0, lastsound=0},
}