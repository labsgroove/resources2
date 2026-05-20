local npcModels = {
    "u_f_y_dancerave_01",
    "a_m_m_afriamer_01",
    "a_m_m_tranvest_01",
    "u_f_y_dancelthr_01",
    "s_f_y_bartender_01",
    "g_m_importexport_01",
    "u_f_y_danceburl_01"
}

RegisterNetEvent("spawnPartyNPCs")
AddEventHandler("spawnPartyNPCs", function(playerCoords)
    -- Criar NPCs perto das coordenadas fornecidas
    for i = 1, 20 do
        local model = npcModels[math.random(#npcModels)]
        RequestModel(model)
        
        while not HasModelLoaded(model) do
            Wait(500)
        end

        -- Definir as coordenadas de spawn com um pequeno deslocamento aleatório
        local spawnCoords = playerCoords + vector3(math.random(-3, 3), math.random(-3, 3), 0)
        local npc = CreatePed(4, model, spawnCoords, 0.0, false, true)
        TaskStartScenarioInPlace(npc, "WORLD_HUMAN_PARTYING", 0, true)
    end
end)
