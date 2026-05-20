local isWalking = false

RegisterCommand('npc', function()
    local playerPed = PlayerPedId()
    if isWalking then
        ClearPedTasksImmediately(playerPed)
        isWalking = false
        QBCore.Functions.Notify('Você voltou ao controle do personagem.')
    else
        TaskWanderStandard(playerPed, 10.0, 10)
        isWalking = true
        QBCore.Functions.Notify('O personagem está andando de forma autônoma.')
    end
end, false)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if isWalking then
            -- Adicione qualquer lógica adicional aqui, se necessário
        end
    end
end)