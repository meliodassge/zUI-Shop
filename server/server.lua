ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('esx_shop:buyItem')
AddEventHandler('esx_shop:buyItem', function(item, price, shopCoords)
    local xPlayer = ESX.GetPlayerFromId(source)

    if not xPlayer then return end

    local validItems = { bread = true, water = true }
    if not validItems[item] then
        return
    end

    if type(price) ~= "number" or price <= 0 then
        return
    end

    local playerCoords = GetEntityCoords(GetPlayerPed(source))
    if #(playerCoords - shopCoords) > 2.0 then
        return
    end

    if xPlayer.getMoney() >= price then
        xPlayer.removeMoney(price)
        xPlayer.addInventoryItem(item, 1)
        TriggerClientEvent('esx:showNotification', source, "Vous avez acheté ~y~1x " .. ESX.GetItemLabel(item) .. "~s~ pour ~g~$" .. price)
    else
        TriggerClientEvent('esx:showNotification', source, "Vous n'avez pas assez d'argent.")
    end
end)