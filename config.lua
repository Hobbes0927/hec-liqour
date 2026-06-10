Config = {}

Config.DefaultLang = 'En'
Config.RemoveItemOnUse = true
Config.CloseInventoryOnUse = true
Config.MetabolismScript = 'fx-hud'  -- fx-hud, vorp-metabolism, or custom (if custom, you will need to use the exports in your metabolism script to update thirst)

Config.ItemsToUse = {
    {
        Name = 'brandy',
        Label = 'Brandy',
        CoreType = 0, -- 0 for Health, 1 for Stamina, -1 to disable
        CoreLength = 120,
        Thirst = 35,
        ObjectModel = 'p_bottlebrandy01x',
        PropId = 'p_bottleJD01x_ph_r_hand',
        ItemInteraction = 'DRINK_BOTTLE@Bottle_Cylinder_D1-3_H30-5_Neck_A13_B2-5_TABLE_HOLD',
        AnimFxType = 'PlayerDrunk01',
        DrunkTime = 90,
    },
    {
        Name = 'tequila',
        Label = 'Tequila',
        CoreType = 0,
        CoreLength = 120,
        Thirst = 35,
        ObjectModel = 'p_bottletequila01x',
        PropId = 'p_bottleJD01x_ph_r_hand',
        ItemInteraction = 'DRINK_BOTTLE@Bottle_Cylinder_D1-3_H30-5_Neck_A13_B2-5_TABLE_HOLD',
        AnimFxType = 'PlayerDrunk01',
        DrunkTime = 90,
    },
    {
        Name = 'whisky',
        Label = 'Whisky',
        CoreType = 0,
        CoreLength = 120,
        Thirst = 35,
        ObjectModel = 'p_bottlejd01x',
        PropId = 'p_bottleJD01x_ph_r_hand',
        ItemInteraction = 'DRINK_BOTTLE@Bottle_Cylinder_D1-3_H30-5_Neck_A13_B2-5_TABLE_HOLD',
        AnimFxType = 'PlayerDrunk01',
        DrunkTime = 90,
    },
    {
        Name = 'beer',
        Label = 'Beer',
        CoreType = 0,
        CoreLength = 90,
        Thirst = 50,
        ObjectModel = 'p_bottlebeer01a',
        PropId = 'p_bottleBeer01x_PH_R_HAND',
        ItemInteraction = 'DRINK_BOTTLE@Bottle_Cylinder_D1-55_H18_Neck_A8_B1-8_TABLE_HOLD',
        AnimFxType = 'PlayerDrunk01',
        DrunkTime = 60,
    },
}
