local QBCore = exports['qb-core']:GetCoreObject()

local Webhooks = {
    ['default'] = 'https://discord.com/api/webhooks/978210149955174460/W22IHEgHDaOwxDIJQU1jyKNBL29a2BwHRq4-WIooaV7urm7gSrSzeYb8X0yEXRNZE25_',
    ['testwebhook'] = 'https://discord.com/api/webhooks/978210219584790538/A60JJDduYJMAKkVPfVx7b7A2173fv1KJdJqWdua-y0eSjUke1Z-ZxhZSd2yXdwwh3MBv',
    ['playermoney'] = 'https://discord.com/api/webhooks/978210304280371230/rkdPTOQLOzDZQUluTB6x9Vt_TXW73egAxHjQAgPJu_rGM3-ZMY3AZA8SIjjjMwNK6rmC',
    ['playerinventory'] = 'https://discord.com/api/webhooks/978210402330624020/aedLZBYKBW48WTr_ozcPj7aadiODwd78Z8Nca7hCeBE4ftlBsaeKazoQN3WgIes9yW83',
    ['robbing'] = 'https://discord.com/api/webhooks/978210495297372260/avB2URuFmSC28cQlrH-flfU45jjJ_EQd7v6vDcpU3uwkxinwuxbXEDmMbSMfM4AXb_u-',
    ['cuffing'] = 'https://discord.com/api/webhooks/978210572485156865/o_2fERc2es6ObvAz6xXXnu2P6_AH_ZULEen72yhg6ynKSWp-NAvqZNJvm9twI9DmUTgU',
    ['drop'] = 'https://discord.com/api/webhooks/978210665258946580/FgMbrXaQC5kG5o7ncOUySCSwQRAXUKiDdud3lmzddmhFUR_2eiBfM2eSD_9ROmEpzjzF',
    ['trunk'] = 'https://discord.com/api/webhooks/978210872063311902/NHXQfzuCh-KKHOst0NpLtwi0F89ihHRJmnfyv26EQQhiURGHjCeyxs6M0lvjbeaqAh6W',
    ['stash'] = 'https://discord.com/api/webhooks/978210949381103637/A_ZR14gRvgrw8f6GbRYXJHP4LtHYNcS7IinQdNuC21yKw5QzbICytCgK-wIoOy8afZ1M',
    ['glovebox'] = 'https://discord.com/api/webhooks/978211010307584010/fXOZVhMBHUEcBxF_u6pW1EycBkadUeasiu0R3dFK_EBd76GWLTWr-zELk5B_RzGc_qaG',
    ['banking'] = 'https://discord.com/api/webhooks/978211148925136908/7zISVSodhEXZ-CTIzzZWS_Xpou5-yp9lk5V7tbtSZ522KS5Bu3wGS_K5EQvOLNyoYwDB',
    ['vehicleshop'] = 'https://discord.com/api/webhooks/974992801240580129/LC2y_4L2_0kgdEVhH5_VbnAdqmXotsFWCTE4Sd-lGW8hQNMItos7dH_zZ4YQDl0KPer9',
    ["police_cars"] = 'https://discord.com/api/webhooks/974988590880784464/zg7kHwEXD7i9mbvgRz6ZILTTBa2tX73se7mupQZAiNe8Y16VyWnkSp5u5uUYFLuONZKX',
    ["medic_cars"] = 'https://discord.com/api/webhooks/975006866130223156/js9kgJ2LJS1wbDHooAo5OQV3JZSJqVwEbWHPlVOqNYEaHDN9kXUIP7-I-Iojf_7DBU4D',
    ['vehicleupgrades'] = 'https://discord.com/api/webhooks/978211359235919883/EVYEY2tiK5yWzt4RfN87lUdEp7DXabB6Pc9_Fc5njvm4aoX-Yhl5_rQiDQ91CL9WqLC-',
    ['shops'] = 'https://discord.com/api/webhooks/974980836891959306/BQepVwQbM2JS0U2cxZFu9Nw4T2aIK5f3jTBYu7kqZuXLd-7sTCghcFCWw-cAeV_c7ud2',
    ["police_armoury"] = 'https://discord.com/api/webhooks/974988423519686696/8AUjHXhOWlrB9K74k6c_VdA7TMVGBWsrM4KpLpkuwkDGYmwnh7E2K_BF39mJ4oz6I_uV',
    ["ambulance_armoury"] = 'https://discord.com/api/webhooks/975006468300500992/PVBQWt7KQlHuj_6_MDB0Hb64Hb1ZNUYSD7DhirAJuq2EGneIXXy7HZz-ae9k-cgOKct7',
    ['dealers'] = 'https://discord.com/api/webhooks/978211459312021514/6ZP3kHSvPJHTnA64H9jvpMbLa2uzYweB5tX6s4qkHPMcJc6obeRSaleBMfvUMytl6Y_X',
    ['powerplants'] = 'https://discord.com/api/webhooks/978211756096749578/KjnQXEluerSm5sFF8O8n5zJjFGDbZI5P9OADimU4a7LjqHkOwDcm-dOfGY9tVbKSGtbY',
    ['death'] = 'https://discord.com/api/webhooks/978211831661330482/LoKhJpYbIzUiiDVXMbk-roi7Mmdjgf1m1IVRhslvtSrahhkNi3CdorBF42_4oZIB9ndh',
    ['joinleave'] = 'https://discord.com/api/webhooks/978211901341335592/3Jl26Q2BC55YBiRhm0PPt1kp9XhvsxtUFa6ctHn40B73TeActm1UL5LAY9m-T52WhVYc',
    ['ooc'] = 'https://discord.com/api/webhooks/978211989832749097/SbHXit8zrr7mdE3YAPRs2buhyIeUSaNIYUZW1tozQ35-Z44662W3jiJ6_pDRUnLYcQ1B',
    ['report'] = 'https://discord.com/api/webhooks/978212114638450708/ftvKwYRCJg16ajB7phPNOjI9WOAKaG6uWHGKcLae2OsbKHb3XcZ9bntw-ghuL5XR8dKe',
    ['me'] = 'https://discord.com/api/webhooks/978212482076278884/hk8EAEte_1y8F1LgKXNuX5C9sNAVmRUq3tDAmrk8oNYNxGqzW-jxSaMbLkNcHT7H06Yj',
    ['pmelding'] = 'https://discord.com/api/webhooks/978212568000770058/F90Oj0cucfvDiaa0Qv2EAhi2rWNb8pB48ikBlNHKF9uX9ub0GhtjCo0gjVg46PfQnemp',
    ['112'] = 'https://discord.com/api/webhooks/978212691598540821/YHnvqF1H0iC5C-3OahU405b-Y89OeH-PnfaMWA2tcDpvkDaoJGkd_jdiI8XnT9UoQfhQ',
    ['bans'] = 'https://discord.com/api/webhooks/978212824952238080/TrilHJn3Zpp0Hj0ll6zZuBTiAvxaonOAMrkNwsvZ5_qZo9Vwvd3I4qfqVvXkbHyp9Ou6',
    ['anticheat'] = 'https://discord.com/api/webhooks/978212890689544212/ymgwBG1GNLC32Z91c2UuaThSiq45qciZXtEoGtcHiKSvSIPiPG5e7oBgW6AdGL41LDV4',
    ['weather'] = 'https://discord.com/api/webhooks/978226359241420800/7i_HsE4YH5gom1ycIggjw6rBoBpHNrxPwp56UKg8EIEpten9_Z_L0LmOmv7FD76sFlgo',
    ['moneysafes'] = 'https://discord.com/api/webhooks/978226574463758336/WBEyqxvrfQi6sXTty3geD1qssZJ-9miQtUKb-3PIijjLGoydrQZDNkmZpQRNCPYtRMDg',
    ['bennys'] = 'https://discord.com/api/webhooks/978226694878019624/5eJ-IcksyciGuSGcAuL3ztI1uNzSwP1GflPU4hBt4tlF9xQLDNSazsebUkg8DWLNGo3X',
    ['bossmenu'] = 'https://discord.com/api/webhooks/978226800461221898/nH2IYVhrQqFuGg1mJDzOAiGacUVo__I9u8oDFy04qOF0DXtapz00eh999LM0Ed81sEau',
    ["police_bossmenu"] = 'https://discord.com/api/webhooks/974988490754359318/PvMyVQ7zktkBXz1-FEYdkR1oeyzVaep5KjkkrndqvFAGIbdPQSepHOFSHqRrHdE4VziN',
    ["ambulance_bossmenu"] = 'https://discord.com/api/webhooks/975006742909952101/I4vUqlFpyWj8mQKHEER6OfZdlXI-86DeibivPko7hBDtmZ8tpBIrQiTRAzZRthigHRuo',
    ['robbery'] = 'https://discord.com/api/webhooks/978226925837377546/e-26WYX10RI-evlt01_-cCG_79XDeqMjz96MR26SyWzuY54UL1DxFvW8i4keWOArqPk-',
    ['casino'] = 'https://discord.com/api/webhooks/978227000399519764/78yA9NNHTM3qcnXA7XqY7UH0nfP6HP1pOdbhR7jjtZ0bmegFJUy28Lf3M9e6JPCLAyLr',
    ['traphouse'] = 'https://discord.com/api/webhooks/978227088102408273/KIeM4DcWFtLn-Z5ZBy0QDl29ZopJJsntYgLgC5f81Bo10pviYzNIcFc0umhI3fG4udts',
    ['911'] = 'https://discord.com/api/webhooks/978227188992188437/utWoCyipKFc5X1eYMhmsvc0BSJubBt882MTnDVwggOIie6NDMhJa5eCP-17Z1K5zOCxJ',
    ['palert'] = 'https://discord.com/api/webhooks/978227293661048873/C3OsJEA8Pl3L0CzvfcdAtMoYia3DtGds315YAh67nMYJPU-CfRk36fW5CiqvtdjfJKeP',
    ['house'] = 'https://discord.com/api/webhooks/978227358773428224/HkoRSBVhmEw1Ol0fz6GPqLfvES30wz6vwAu4G2ei-z4DQfVxaTjBktlnkkY1xbMDH9Gg',
    ["police_parking"] = 'https://discord.com/api/webhooks/974988727858389022/ZutOg-g0M2Lha2BYp-RWJ6QHN-KwReBhJPQTkWDIdWcTz60CsNX2rIGKIwRPqkt6QylQ',
    ["police_mdt"] = 'https://discord.com/api/webhooks/974988660229435423/RID6L-eOcF9GKU0Hid9VGCWNTxyyImqNmqbSeZ9K8TXvwoB9zHn39CtNqG83J8PqaHm-',
    ["police_dispatch"] = 'https://discord.com/api/webhooks/974988794996600862/Rf2SfmBCKumAWoRNR3cKphI8cbVnofhmWHJOI8ztc_JzInsKUTMAlR5fl3Wkb1U5aFFd',
    ["police_shiftlog"]= 'https://discord.com/api/webhooks/975265490622619649/hj4FI08OhZLkG4u-MZ2fC1orhXFsygqXSnEmVfuZwIT9o84rQ_XzAyUdMl6JSKPNSK4U',
    ["ambulance_shiftlog"]= 'https://discord.com/api/webhooks/975265685267697744/Dznfpa-TVg-QQtnWzzSI5ljwloNsYwZbpmnypgWIq93bzsfs3v1EOrr4XgW55oboCDiJ',
    ["taxi_shiftlog"]= 'https://discord.com/api/webhooks/975265817702826014/QTXz3NEImrZNvPde2ZzhEYgG4csFbSuivXPDA0EES5x0jAOCVz0Vb4iYtivAAvou72xf',
    ["mechanic_shiftlog"]= 'https://discord.com/api/webhooks/975265817702826014/QTXz3NEImrZNvPde2ZzhEYgG4csFbSuivXPDA0EES5x0jAOCVz0Vb4iYtivAAvou72xf',
    ["adminlog"] = 'https://discord.com/api/webhooks/983413654068277318/S7gT-ziQkUKjTJq0ckG3cu4uv9QykmwL7-YSyu5FUd8StSrm5fqza8LKqwED0eC6ihKA',
    ['admin'] = 'https://discord.com/api/webhooks/1000465983275806760/8rN7_z8YlIHszy2pw77EbmCnao-zs9Ld0qC3Q4mcmue5W_30QKmqt-7r4UfLgeDoWtJl',
    --robberys
    ["truckrobbery"]= 'https://discord.com/api/webhooks/987986835114426388/zCis6idsMN5rFR7MYSUyp86JwrY9CBSD4IR24o2U0o8lafJlFNeDEKq3MV69Eq6IvkzS',
    ['storerobbery'] = 'https://discord.com/api/webhooks/987977180883591198/VrKGCE1J2XeLKwMiitC2L4rc-4tqY64rskfr5HJjS44Rb2VmKcLPAlvZghD8a4z4r8v4',
    ['bankrobbery'] = 'https://discord.com/api/webhooks/978211669752832020/SGmlwMlSw0dXpp61TuSmAVHFcflUhNwteDonocAZTIfipZrQNw3xAi5Nek0coEtLl4cU',
    ['repairgun'] = 'https://discord.com/api/webhooks/978211669752832020/SGmlwMlSw0dXpp61TuSmAVHFcflUhNwteDonocAZTIfipZrQNw3xAi5Nek0coEtLl4cU',
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
                ['name'] = 'DelightRP Logs',
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
