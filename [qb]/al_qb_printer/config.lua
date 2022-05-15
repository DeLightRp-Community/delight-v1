Config = {}

Config.PrintInkAmount = 2 --[[ percent value ]]
Config.BlackWhiteMultiplier = 0.5 --[[ multiplier for the amount of ink to be used for balck and white ]]

Config.PaperBundle = 10 --[[ how many papers a paper bundle contains ]]
Config.MaxPapers = 50 --[[ maximum amount of papers in printer ]]

Config.Printers = {
    {
        coords = vector3(450.08, -988.92, 30.69),
        heading = 0.0, --[[ this is for the model ]]
        --model = {prop = "v_ret_gc_print", onGround = false} --[[ if on ground then it will automatically set it on ground, else it will float in the air as if oyu want it to be on a table ]]
    },
	{
        coords = vector3(342.22, -577.17, 43.28),
        heading = 0.0, --[[ this is for the model ]]
        -- model = {prop = "v_ret_gc_print", onGround = false} --[[ if on ground then it will automatically set it on ground, else it will float in the air as if oyu want it to be on a table ]]
    },
}