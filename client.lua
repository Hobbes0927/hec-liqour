local VORPCore = exports.vorp_core:GetCore()
local isDrinking = false
local isDrunk = false
local drunkTimer = 0
local currentEffect = nil

local function translate(key)
    local lang = Config.DefaultLang or 'En'
    local selected = Locales and Locales[lang] or nil
    local english = Locales and Locales.En or nil

    return (selected and selected[key]) or (english and english[key]) or key
end

local function notifyTip(message, duration)
    if VORPCore and VORPCore.NotifyTip then
        VORPCore.NotifyTip(message, duration)
        return
    end

    TriggerEvent('vorp:Tip', message, duration)
end

local function applyCoreBoosts(ped, coreType, coreLength)
    if coreType == nil or coreType == -1 then
        return
    end

    Citizen.InvokeNative(0xC6258F41D86676E0, ped, coreType, 100) -- SetAttributeCoreValue
    Citizen.InvokeNative(0x4AF5A4C7B9157D14, ped, coreType, 120.0)
    Citizen.InvokeNative(0xF6A7C08DF2E28B28, ped, 0, 120.0)
end

local function startDrunkEffect(effectName, drunkTime)
    drunkTimer = drunkTime or 120
    currentEffect = effectName
    isDrunk = true

    if currentEffect and currentEffect ~= '' then
        AnimpostfxPlay(currentEffect)
    end

    Citizen.InvokeNative(0x406CCF555B04FAD3, PlayerPedId(), 1, 1.0)
end

local function stopDrunkEffect()
    Citizen.InvokeNative(0x406CCF555B04FAD3, PlayerPedId(), 1, 0.0)

    if currentEffect and currentEffect ~= '' and AnimpostfxIsRunning(currentEffect) then
        AnimpostfxStop(currentEffect)
    end

    isDrunk = false
    drunkTimer = 0
    currentEffect = nil
end

local function playDrinkInteraction(item)
    if isDrinking then
        return
    end

    isDrinking = true

    local ped = PlayerPedId()
    local coords = GetEntityCoords(ped)
    local object = CreateObject(GetHashKey(item.ObjectModel), coords.x, coords.y, coords.z, false, true, false, false, true)

    TaskItemInteraction_2(
        ped,
        -1199896558,
        object,
        GetHashKey(item.PropId),
        GetHashKey(item.ItemInteraction),
        1,
        0,
        -1.0
    )

    while isDrinking do
        Wait(1)

        if not DoesEntityExist(object) then
            isDrinking = false

            if not isDrunk then
                startDrunkEffect(item.AnimFxType, item.DrunkTime)
                applyCoreBoosts(ped, item.CoreType, item.CoreLength)
                notifyTip(translate('you_consumed') .. item.Label, 3000)
            end
        end
    end

    if Config.MetabolismScript == 'fx-hud' then
         exports['fx-hud']:setStatus("thirst", item.Thirst)
    elseif Config.MetabolismScript == 'vorp-metabolism' then
        TriggerEvent('vorpmetabolism:changeValue', 'Thirst', item.Thirst)
    else
        --Enter custom metabolism script integration here, or leave as is to skip metabolism effects.
        print('No metabolism script configured, skipping metabolism effects.')
    end
    
end

RegisterNetEvent('poke_licor:useItem', function(item, coreType, objectModel, propId, itemInteraction, animFxType)
    if type(item) == 'table' then
        playDrinkInteraction(item)
        return
    end

    -- Legacy compatibility for callers using the original C# event signature.
    playDrinkInteraction({
        Label = item,
        CoreType = coreType,
        ObjectModel = objectModel,
        PropId = propId,
        ItemInteraction = itemInteraction,
        AnimFxType = animFxType
    })
end)

CreateThread(function()
    while true do
        Wait(1000)

        if isDrunk then
            if drunkTimer > 0 then
                drunkTimer = drunkTimer - 1
            else
                stopDrunkEffect()
            end
        end
    end
end)

AddEventHandler('onResourceStop', function(resourceName)
    if resourceName == GetCurrentResourceName() and isDrunk then
        stopDrunkEffect()
    end
end)
