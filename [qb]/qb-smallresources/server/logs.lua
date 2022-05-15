local QBCore = exports['qb-core']:GetCoreObject()

local Webhooks = {
    ['default'] = '',
    ['testwebhook'] = '',
    ['playermoney'] = '',
    ['playerinventory'] = '',
    ['robbing'] = '',
    ['cuffing'] = '',
    ['drop'] = '',
    ['trunk'] = '',
    ['stash'] = '',
    ['glovebox'] = '',
    ['banking'] = '',
    ['vehicleshop'] = 'https://discord.com/api/webhooks/974992801240580129/LC2y_4L2_0kgdEVhH5_VbnAdqmXotsFWCTE4Sd-lGW8hQNMItos7dH_zZ4YQDl0KPer9',
    ["police_cars"] = 'https://discord.com/api/webhooks/974988590880784464/zg7kHwEXD7i9mbvgRz6ZILTTBa2tX73se7mupQZAiNe8Y16VyWnkSp5u5uUYFLuONZKX',
    ["medic_cars"] = 'https://discord.com/api/webhooks/975006866130223156/js9kgJ2LJS1wbDHooAo5OQV3JZSJqVwEbWHPlVOqNYEaHDN9kXUIP7-I-Iojf_7DBU4D',
    ['vehicleupgrades'] = '',
    ['shops'] = 'https://discord.com/api/webhooks/974980836891959306/BQepVwQbM2JS0U2cxZFu9Nw4T2aIK5f3jTBYu7kqZuXLd-7sTCghcFCWw-cAeV_c7ud2',
    ["police_armoury"] = 'https://discord.com/api/webhooks/974988423519686696/8AUjHXhOWlrB9K74k6c_VdA7TMVGBWsrM4KpLpkuwkDGYmwnh7E2K_BF39mJ4oz6I_uV',
    ["ambulance_armoury"] = 'https://discord.com/api/webhooks/975006468300500992/PVBQWt7KQlHuj_6_MDB0Hb64Hb1ZNUYSD7DhirAJuq2EGneIXXy7HZz-ae9k-cgOKct7',
    ['dealers'] = '',
    ['storerobbery'] = '',
    ['bankrobbery'] = '',
    ['powerplants'] = '',
    ['death'] = '',
    ['joinleave'] = '',
    ['ooc'] = '',
    ['report'] = '',
    ['me'] = '',
    ['pmelding'] = '',
    ['112'] = '',
    ['bans'] = '',
    ['anticheat'] = '',
    ['weather'] = '',
    ['moneysafes'] = '',
    ['bennys'] = '',
    ['bossmenu'] = '',
    ["police_bossmenu"] = 'https://discord.com/api/webhooks/974988490754359318/PvMyVQ7zktkBXz1-FEYdkR1oeyzVaep5KjkkrndqvFAGIbdPQSepHOFSHqRrHdE4VziN',
    ["ambulance_bossmenu"] = 'https://discord.com/api/webhooks/975006742909952101/I4vUqlFpyWj8mQKHEER6OfZdlXI-86DeibivPko7hBDtmZ8tpBIrQiTRAzZRthigHRuo',
    ['robbery'] = '',
    ['casino'] = '',
    ['traphouse'] = '',
    ['911'] = '',
    ['palert'] = '',
    ['house'] = '',
    ["police_parking"] = 'https://discord.com/api/webhooks/974988727858389022/ZutOg-g0M2Lha2BYp-RWJ6QHN-KwReBhJPQTkWDIdWcTz60CsNX2rIGKIwRPqkt6QylQ',
    ["police_mdt"] = 'https://discord.com/api/webhooks/974988660229435423/RID6L-eOcF9GKU0Hid9VGCWNTxyyImqNmqbSeZ9K8TXvwoB9zHn39CtNqG83J8PqaHm-',
    ["police_dispatch"] = 'https://discord.com/api/webhooks/974988794996600862/Rf2SfmBCKumAWoRNR3cKphI8cbVnofhmWHJOI8ztc_JzInsKUTMAlR5fl3Wkb1U5aFFd',
    ["police_shiftlog"]= 'https://discord.com/api/webhooks/975265490622619649/hj4FI08OhZLkG4u-MZ2fC1orhXFsygqXSnEmVfuZwIT9o84rQ_XzAyUdMl6JSKPNSK4U',
    ["ambulance_shiftlog"]= 'https://discord.com/api/webhooks/975265685267697744/Dznfpa-TVg-QQtnWzzSI5ljwloNsYwZbpmnypgWIq93bzsfs3v1EOrr4XgW55oboCDiJ',
    ["taxi_shiftlog"]= 'https://discord.com/api/webhooks/975265817702826014/QTXz3NEImrZNvPde2ZzhEYgG4csFbSuivXPDA0EES5x0jAOCVz0Vb4iYtivAAvou72xf',
    ["mechanic_shiftlog"]= 'https://discord.com/api/webhooks/975265817702826014/QTXz3NEImrZNvPde2ZzhEYgG4csFbSuivXPDA0EES5x0jAOCVz0Vb4iYtivAAvou72xf',
}

local Colors = { -- https://www.spycolor.com/
    ['default'] = 14423100,
    ['blue'] = 255,
    ['red'] = 16711680,
    ['green'] = 65280,
    ['white'] = 16777215,
    ['black'] = 0,
    ['orange'] = 16744192,
    ['yellow'] = 16776960,
    ['pink'] = 16761035,
    ["lightgreen"] = 65309,
}

RegisterNetEvent('qb-log:server:CreateLog', function(name, title, color, message, tagEveryone)        
    local tag = tagEveryone or false
    local webHook = Webhooks[name] or Webhooks['default']
    local embedData = {
        {
            ['title'] = title,
            ['color'] = Colors[color] or Colors['default'],
            ['footer'] = {
                ['text'] = os.date('%c'),
            },
            ['description'] = message,
            ['author'] = {
                ['name'] = 'DelightRPa Logs',
                ['icon_url'] = 'https://cdn.discordapp.com/attachments/930782372155260939/973539190576906351/56569569659.png?size=4096',
            },
        }
    }
    PerformHttpRequest(webHook, function(err, text, headers) end, 'POST', json.encode({ username = 'QB Logs', embeds = embedData}), { ['Content-Type'] = 'application/json' })
    Citizen.Wait(100)
    if tag then
        PerformHttpRequest(webHook, function(err, text, headers) end, 'POST', json.encode({ username = 'QB Logs', content = '@everyone'}), { ['Content-Type'] = 'application/json' })
    end
end)

QBCore.Commands.Add('testwebhook', 'Test Your Discord Webhook For Logs (God Only)', {}, false, function(source, args)
    TriggerEvent('qb-log:server:CreateLog', 'testwebhook', 'Test Webhook', 'default', 'Webhook setup successfully')
end, 'god')
