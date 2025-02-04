local zUI = exports.zUI:getSharedObject()
local ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
end)

local shopItems = {
    { label = "Pain", item = "bread", price = 10 },
    { label = "Eau", item = "water", price = 5 }
}

local shopLocations = {
    vector3(25.7, -1347.3, 29.5),    -- Innocence Blvd
    vector3(-48.5, -1757.5, 29.4),   -- Route 68
    vector3(1135.8, -982.3, 46.4),   -- Mirror Park
    vector3(1163.4, -323.9, 69.2),   -- Vinewood Blvd
    vector3(-707.5, -914.3, 19.2),   -- Little Seoul
    vector3(-1222.9, -906.9, 12.3),  -- San Andreas Ave
    vector3(-1487.6, -379.5, 40.2),  -- Great Ocean Highway
    vector3(-2968.2, 390.9, 15.0),   -- Chumash
    vector3(1166.0, 2708.9, 38.2),   -- Route 68 (près de Sandy Shores)
    vector3(1392.6, 3604.2, 34.9),   -- Sandy Shores
    vector3(-1393.4, -606.6, 30.3),  -- La Mesa
    vector3(-1037.6, -2737.6, 20.2), -- Route 68 (près de l'aéroport)
    vector3(1698.4, 4924.1, 42.1),   -- Grapeseed
    vector3(1961.5, 3741.9, 32.3),   -- Alhambra Dr
    vector3(2678.9, 3280.6, 55.2),   -- East Joshua Rd
    vector3(2557.1, 382.0, 108.6),   -- Paleto Bay
    vector3(373.9, 326.8, 103.6),    -- Banham Canyon Dr
    vector3(-3241.9, 1001.5, 12.8),  -- Barbareno Rd
    vector3(-1820.5, 792.5, 138.1),  -- North Rockford Dr
    vector3(547.4, 2671.8, 42.2),    -- Route 68 (près de Harmony)
    vector3(1729.2, 6415.5, 35.0),   -- Route 68 (près de la prison)
    vector3(-2539.2, 2314.3, 33.2),  -- Great Ocean Highway (près de la côte)
    vector3(-3039.5, 585.9, 7.9),    -- Barbareno Rd (près de la plage)
    vector3(-3040.4, 589.5, 7.9),    -- Barbareno Rd (près de la plage, deuxième magasin)
    vector3(-2967.8, 390.9, 15.0),   -- Chumash (près de la station-service)
    vector3(-3243.9, 1001.5, 12.8),  -- Barbareno Rd (près de la plage, troisième magasin)
    vector3(1391.9, 3604.9, 34.9),   -- Sandy Shores (près de l'aérodrome)
    vector3(1165.9, 2709.0, 38.2),   -- Route 68 (près de Sandy Shores, deuxième magasin)
    vector3(-1487.5, -379.4, 40.2),  -- Great Ocean Highway (près de la côte)
    vector3(-1222.8, -906.8, 12.3),  -- San Andreas Ave (près de la station-service)
    vector3(-707.4, -914.2, 19.2),   -- Little Seoul (près du centre-ville)
    vector3(1135.7, -982.2, 46.4),   -- Mirror Park (près du lac)
    vector3(1163.3, -323.8, 69.2),   -- Vinewood Blvd (près du cinéma)
    vector3(-48.4, -1757.4, 29.4),   -- Route 68 (près de la station-service)
    vector3(25.6, -1347.2, 29.5)     -- Innocence Blvd (près du centre-ville)
}

Citizen.CreateThread(function()
    for _, location in pairs(shopLocations) do
        local blip = AddBlipForCoord(location.x, location.y, location.z)
        SetBlipSprite(blip, 52)
        SetBlipDisplay(blip, 4)
        SetBlipScale(blip, 0.8)
        SetBlipColour(blip, 2)
        SetBlipAsShortRange(blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString("Magasin")
        EndTextCommandSetBlipName(blip)
    end
end)

local function getPlayerGrid(coords)
    local gridSize = 100.0
    local gridX = math.floor((coords.x + 8192) / gridSize)
    local gridY = math.floor((coords.y + 8192) / gridSize)
    return gridX .. "-" .. gridY
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(100)
        local playerCoords = GetEntityCoords(PlayerPedId())
        local playerGrid = getPlayerGrid(playerCoords)

        for _, location in pairs(shopLocations) do
            local shopGrid = getPlayerGrid(location)
            if shopGrid == playerGrid then
                local distance = #(playerCoords - location)
                if distance < 20.0 then
                    DrawMarker(1, location.x, location.y, location.z - 1.0, 0, 0, 0, 0, 0, 0, 1.0, 1.0, 1.0, 0, 255, 0, 150, false, true, 2, nil, nil, false)
                    
                    ESX.Game.Utils.DrawText3D(location, "Appuyez sur [E] pour ouvrir le magasin", 0.6)

                    if distance < 2.0 and IsControlJustReleased(0, 38) then -- 38 = Touche E
                        openShop(location)
                    end
                end
            end
        end
    end
end)

local function openShop(shopCoords)
    local options = {}
    for _, item in pairs(shopItems) do
        table.insert(options, {
            label = item.label .. " - $" .. item.price,
            value = item.item,
            price = item.price
        })
    end

    zUI.OpenMenu("Magasin", options, function(selected)
        if selected then
            TriggerServerEvent('esx_shop:buyItem', selected.value, selected.price, shopCoords)
        end
    end)
end