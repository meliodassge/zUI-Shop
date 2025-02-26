ItemsData = {}

---@alias BadgeName
---| "ARROW_LEFT"
---| "ARROW_RIGHT"
---| "BETTING_BOX_CENTER"
---| "BETTING_BOX_LEFT"
---| "BETTING_BOX_RIGHT"
---| "CARD_SUIT_CLUBS"
---| "CARD_SUIT_DIAMONDS"
---| "CARD_SUIT_HEARTS"
---| "CARD_SUIT_SPADES"
---| "MEDAL_SILVER"
---| "ALERT_TRIANGLE"
---| "HOST_CROWN"
---| "MEDAL_BRONZE"
---| "MEDAL_GOLD"
---| "CASH"
---| "SPEC_ITEM_COKE"
---| "SPEC_ITEM_HEROIN"
---| "SPEC_ITEM_METH"
---| "SPEC_ITEM_WEED"
---| "AMMO_ICON_A"
---| "AMMO_ICON_B"
---| "ARMOUR_ICON_A"
---| "ARMOUR_ICON_B"
---| "ARROWS_UPDOWN"
---| "ART_ICON_A"
---| "ART_ICON_B"
---| "BARBER_ICON_A"
---| "BARBER_ICON_B"
---| "BOX_BLANK_A"
---| "BOX_BLANK_B"
---| "BOX_CROSS_B"
---| "BOX_TICK_A"
---| "BOX_TICK_B"
---| "CHIPS_A"
---| "CHIPS_B"
---| "CLOTHING_ICON_A"
---| "CLOTHING_ICON_B"
---| "FRANKLIN_ICON_A"
---| "FRANKLIN_ICON_B"
---| "GARAGE_BIKE_A"
---| "GARAGE_BIKE_B"
---| "GARAGE_ICON_A"
---| "GARAGE_ICON_B"
---| "GUNCLUB_ICON_A"
---| "GUNCLUB_ICON_B"
---| "HEALTH_ICON_A"
---| "HEALTH_ICON_B"
---| "LOCK_ICON"
---| "LOCK_ARENA"
---| "MAKEUP_ICON_A"
---| "MAKEUP_ICON_B"
---| "MASK_ICON_A"
---| "MASK_ICON_B"
---| "MICHAEL_ICON_A"
---| "MICHAEL_ICON_B"
---| "NEW_STAR"
---| "TATTOOS_ICON_A"
---| "TATTOOS_ICON_B"
---| "TICK_ICON"
---| "TREVOR_ICON_A"
---| "TREVOR_ICON_B"
---| string


RegisterNUICallback("zUI-Hover", function(data, cb)
    for key, item in pairs(ItemsData) do
        if key ~= data.actionId then
            item.action(false, false)
        end
    end
    local actionData = ItemsData[data.actionId]
    if actionData.action then
        actionData.action(false, true)
    end
    cb("ok")
end)
