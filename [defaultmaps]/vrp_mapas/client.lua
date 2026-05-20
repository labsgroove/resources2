local pdl = GetInteriorAtCoords(440.84, -983.14, 30.69)  -- Fix limbo DP
LoadInterior(pdl)


local bennys = GetInteriorAtCoords(-210.29,-1321.87,30.89)  --Benny's
LoadInterior(bennys)

Citizen.CreateThread(function()  -- Fix casa do Franklin
interiorID = GetInteriorAtCoords(3.199463, 529.7808, 169.6262)
	if IsValidInterior(interiorID) then
		EnableInteriorProp(interiorID, "locked")
		RefreshInterior(interiorID)
	end
end)

Citizen.CreateThread(function()
interiorID = GetInteriorAtCoords(96.47223, 6347.784,30.48238)
	if IsValidInterior(interiorID) then
		EnableInteriorProp(interiorID, "weed_hosea")
		EnableInteriorProp(interiorID, "weed_hoseb")
		EnableInteriorProp(interiorID, "weed_hosec")
		EnableInteriorProp(interiorID, "weed_hosed")
		EnableInteriorProp(interiorID, "weed_hosee")
		EnableInteriorProp(interiorID, "weed_hosef")
		EnableInteriorProp(interiorID, "weed_hoseg")
		EnableInteriorProp(interiorID, "weed_hoseh")
		EnableInteriorProp(interiorID, "weed_hosei")
		EnableInteriorProp(interiorID, "weed_growtha_stage3")
		EnableInteriorProp(interiorID, "weed_growthb_stage3")
		EnableInteriorProp(interiorID, "weed_growthc_stage3")
		EnableInteriorProp(interiorID, "weed_growthd_stage3")
		EnableInteriorProp(interiorID, "weed_growthe_stage3")
		EnableInteriorProp(interiorID, "weed_growthf_stage3")
		EnableInteriorProp(interiorID, "weed_growthg_stage3")
		EnableInteriorProp(interiorID, "weed_growthh_stage3")
		EnableInteriorProp(interiorID, "weed_growthi_stage3")
		EnableInteriorProp(interiorID, "light_growtha_stage33_upgrade")
		EnableInteriorProp(interiorID, "light_growthb_stage33_upgrade")
		EnableInteriorProp(interiorID, "light_growthc_stage33_upgrade")
		EnableInteriorProp(interiorID, "light_growthd_stage33_upgrade")
		EnableInteriorProp(interiorID, "light_growthe_stage33_upgrade")
		EnableInteriorProp(interiorID, "light_growthf_stage33_upgrade")
		EnableInteriorProp(interiorID, "light_growthg_stage33_upgrade")
		EnableInteriorProp(interiorID, "light_growthh_stage33_upgrade")
		EnableInteriorProp(interiorID, "light_growthi_stage33_upgrade")
		EnableInteriorProp(interiorID, "weed_upgrade_equip")
		EnableInteriorProp(interiorID, "weed_drying")
		EnableInteriorProp(interiorID, "weed_security_upgrade")
		EnableInteriorProp(interiorID, "weed_production")
		EnableInteriorProp(interiorID, "weed_set_up")
		EnableInteriorProp(interiorID, "weed_chairs")
		RefreshInterior(interiorID)	
	end

interiorID = GetInteriorAtCoords(-1103.1722412109,4951.3447265625,234.8638)
	if IsValidInterior(interiorID) then
		EnableInteriorProp(interiorID, "coke_cut_01")
		EnableInteriorProp(interiorID, "coke_cut_02")
		EnableInteriorProp(interiorID, "coke_cut_03")
		EnableInteriorProp(interiorID, "coke_cut_04")
		EnableInteriorProp(interiorID, "coke_cut_05")
		EnableInteriorProp(interiorID, "set_up")
		EnableInteriorProp(interiorID, "security_high")
		EnableInteriorProp(interiorID, "production_upgrade")
		EnableInteriorProp(interiorID, "equipment_upgrade")
		RefreshInterior(interiorID)
	end

RequestIpl("imp_impexp_interior_placement_interior_1_impexp")
interiorID = GetInteriorAtCoords(941.10520000,-971.67590000,39.39997000)
	if IsValidInterior(interiorID) then
		EnableInteriorProp(interiorID, "branded_style_set")
		EnableInteriorProp(interiorID, "car_floor_hatch")
		EnableInteriorProp(interiorID, "door_blocker")
		RefreshInterior(interiorID)
	end		

interiorID = GetInteriorAtCoords(-47.1,-1115.3,26.5)  -- Concessionária
	if IsValidInterior(interiorID) then
		EnableInteriorProp(interiorID, "csr_beforeMission")
		EnableInteriorProp(interiorID, "csr_inMission")
		RefreshInterior(interiorID)
	end

interiorID = GetInteriorAtCoords(-802.3,175.0,72.8)  -- Mansão do Michael
	if IsValidInterior(interiorID) then
		EnableInteriorProp(interiorID, "V_Michael_bed_tidy")
		EnableInteriorProp(interiorID, "V_Michael_M_items")
		EnableInteriorProp(interiorID, "V_Michael_D_items")
		EnableInteriorProp(interiorID, "V_Michael_S_items")
		EnableInteriorProp(interiorID, "V_Michael_L_Items")
		RefreshInterior(interiorID)
	end

RequestIpl("imp_impexp_interior_placement_interior_1_impexp")
interiorID = GetInteriorAtCoords(941.10520000,-971.67590000,39.39997000)  -- Import e Export
	if IsValidInterior(interiorID) then
		EnableInteriorProp(interiorID, "garage_decor_01")
		EnableInteriorProp(interiorID, "garage_decor_02")
		EnableInteriorProp(interiorID, "garage_decor_03")
		EnableInteriorProp(interiorID, "garage_decor_04")
		EnableInteriorProp(interiorID, "lighting_option01")
		EnableInteriorProp(interiorID, "lighting_option02")
		EnableInteriorProp(interiorID, "lighting_option03")
		EnableInteriorProp(interiorID, "lighting_option04")
		EnableInteriorProp(interiorID, "lighting_option05")
		EnableInteriorProp(interiorID, "lighting_option06")
		EnableInteriorProp(interiorID, "lighting_option07")
		EnableInteriorProp(interiorID, "lighting_option08")
		EnableInteriorProp(interiorID, "lighting_option09")
		EnableInteriorProp(interiorID, "numbering_style01_n3")
		EnableInteriorProp(interiorID, "numbering_style02_n3")
		EnableInteriorProp(interiorID, "numbering_style03_n3")
		EnableInteriorProp(interiorID, "numbering_style04_n3")
		EnableInteriorProp(interiorID, "numbering_style05_n3")
		EnableInteriorProp(interiorID, "numbering_style06_n3")
		EnableInteriorProp(interiorID, "numbering_style07_n3")
		EnableInteriorProp(interiorID, "numbering_style08_n3")
		EnableInteriorProp(interiorID, "numbering_style09_n3")
		EnableInteriorProp(interiorID, "floor_vinyl_01")
		EnableInteriorProp(interiorID, "floor_vinyl_02")
		EnableInteriorProp(interiorID, "floor_vinyl_03")
		EnableInteriorProp(interiorID, "floor_vinyl_04")
		EnableInteriorProp(interiorID, "floor_vinyl_05")
		EnableInteriorProp(interiorID, "floor_vinyl_06")
		EnableInteriorProp(interiorID, "floor_vinyl_07")
		EnableInteriorProp(interiorID, "floor_vinyl_08")
		EnableInteriorProp(interiorID, "floor_vinyl_09")
		EnableInteriorProp(interiorID, "floor_vinyl_10")
		EnableInteriorProp(interiorID, "floor_vinyl_11")
		EnableInteriorProp(interiorID, "floor_vinyl_12")
		EnableInteriorProp(interiorID, "floor_vinyl_13")
		EnableInteriorProp(interiorID, "floor_vinyl_14")
		EnableInteriorProp(interiorID, "floor_vinyl_15")
		EnableInteriorProp(interiorID, "floor_vinyl_16")
		EnableInteriorProp(interiorID, "floor_vinyl_17")
		EnableInteriorProp(interiorID, "floor_vinyl_18")
		EnableInteriorProp(interiorID, "floor_vinyl_19")
		EnableInteriorProp(interiorID, "floor_vinyl_19")
		EnableInteriorProp(interiorID, "branded_style_set")
		--EnableInteriorProp(interiorID, "urban_style_set")
		EnableInteriorProp(interiorID, "door_blocker")
		RefreshInterior(interiorID)
	end		

interiorID = GetInteriorAtCoords(-1604.664, -3012.583, -78.00)  -- Galaxy
	if IsValidInterior(interiorID) then
		EnableInteriorProp(interiorID , "Int01_ba_security_upgrade")
		EnableInteriorProp(interiorID , "Int01_ba_equipment_setup")
		EnableInteriorProp(interiorID , "Int01_ba_Style02") -- средний
		EnableInteriorProp(interiorID , "Int01_ba_style02_podium") -- средний
		EnableInteriorProp(interiorID , "int01_ba_lights_screen")
		EnableInteriorProp(interiorID , "Int01_ba_Screen")
		EnableInteriorProp(interiorID , "Int01_ba_bar_content")
		EnableInteriorProp(interiorID , "Int01_ba_dj02")
		EnableInteriorProp(interiorID , "DJ_04_Lights_01")
		EnableInteriorProp(interiorID , "Int01_ba_lightgrid_01")
		EnableInteriorProp(interiorID , "Int01_ba_equipment_upgrade")
		EnableInteriorProp(interiorID , "Int01_ba_clubname_01") -- galaxy
		EnableInteriorProp(interiorID , "Int01_ba_dry_ice")
		EnableInteriorProp(interiorID , "Int01_ba_deliverytruck")
		EnableInteriorProp(interiorID , "Int01_ba_trophy01")
		EnableInteriorProp(interiorID , "Int01_ba_trophy02")
		EnableInteriorProp(interiorID , "Int01_ba_trophy03")
		EnableInteriorProp(interiorID , "Int01_ba_trophy04")
		EnableInteriorProp(interiorID , "Int01_ba_trophy05")
		EnableInteriorProp(interiorID , "Int01_ba_trophy07")
		EnableInteriorProp(interiorID , "Int01_ba_trophy08")
		EnableInteriorProp(interiorID , "Int01_ba_trophy09")
		EnableInteriorProp(interiorID , "Int01_ba_trophy10")
		EnableInteriorProp(interiorID , "Int01_ba_trophy11")
		EnableInteriorProp(interiorID , "Int01_ba_trad_lights")
		EnableInteriorProp(interiorID , "DJ_04_Lights_04")
		EnableInteriorProp(interiorID, "Int01_ba_clubname_01")
		RefreshInterior(interiorID)
	end
end)
