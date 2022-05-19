SimpleBanking = SimpleBanking or {} 
SimpleBanking.Config = SimpleBanking.Config or {}


SimpleBanking.Config["Days_Transaction_History"] = 5 -- How many days should the transaction history go back in the bank?

SimpleBanking.Config["business_ranks"] = { -- what ranks can see the society accounts in the menu, and deposit/withdraw/transfer from them?
    ['Manager'] = true,
    ['owner'] = true,
    ['CEO'] = true,
    ['Boss'] = true,
}

SimpleBanking.Config["business_ranks_overrides"] = {
    ['police'] = {
        ['Ast. Chief'] = true,
        ['Chief of Police'] = true
    },
    ['ambulance'] = {
        ['EMS Chief'] = true,
        ['Captain'] = true,
        ['Lieutenant'] = true,
    },
    ['nightclub'] = {
        ['Galaxy Club Owner'] =true
    }
    
}

SimpleBanking.Config["gang_ranks"] = {
    ['boss'] = true,

}

SimpleBanking.Config["gang_ranks_overrides"] = {

}
