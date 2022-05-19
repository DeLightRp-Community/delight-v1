local QBCore = exports["qb-core"]:GetCoreObject()

exports["qb-target"]:AddTargetModel(-874338148, {
    options = {
        {
            type = "client",
            event = "loaf_spikestrips:removeSpikestrip",
            icon = "fa fa-circle",
            label = "Remove Spike",
            job = "police",
        },
    },
    distance = 2.0
})