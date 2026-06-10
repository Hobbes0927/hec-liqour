local function getItemMetadata(data)
    if data and data.item and data.item.metadata then
        return data.item.metadata
    end

    if data and data.metadata then
        return data.metadata
    end

    return {}
end

local function registerLiquorItems()
    for _, liquor in ipairs(Config.ItemsToUse) do
        local item = liquor

        exports.vorp_inventory:registerUsableItem(item.Name, function(data)
            local src = data and data.source
            if not src then
                return
            end

            if Config.CloseInventoryOnUse then
                exports.vorp_inventory:closeInventory(src)
            end

            if Config.RemoveItemOnUse then
                exports.vorp_inventory:subItem(src, item.Name, 1, getItemMetadata(data))
            end

            TriggerClientEvent('poke_licor:useItem', src, item)
        end)
    end

    print(('[%s] Registered %s VORP liquor items.'):format(GetCurrentResourceName(), #Config.ItemsToUse))
end

CreateThread(registerLiquorItems)
