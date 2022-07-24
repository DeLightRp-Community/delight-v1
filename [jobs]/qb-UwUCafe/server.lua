local QBCore = exports['qb-core']:GetCoreObject()

-------- comidas ----------

RegisterNetEvent('mt-UwUCafe:server:FazerCupcakeMorango', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local pacoteleite = Player.Functions.GetItemByName('pacote-leite').amount
    local barramanteiga = Player.Functions.GetItemByName('barra-manteiga').amount
    local pacotefarinha = Player.Functions.GetItemByName('pacote-farinha').amount
    local caixamorangos = Player.Functions.GetItemByName('caixa-morangos').amount

    if pacoteleite ~=nil and barramanteiga ~=nil and pacotefarinha ~=nil and caixamorangos ~=nil and pacoteleite >=2 and barramanteiga >=2 and pacotefarinha >=2 and caixamorangos >=2 then

        Player.Functions.RemoveItem('pacote-leite', 2)
        Player.Functions.RemoveItem('barra-manteiga', 2)
        Player.Functions.RemoveItem('pacote-farinha', 2)
        Player.Functions.RemoveItem('caixa-morangos', 2)
        Player.Functions.AddItem('cupcake-morango', 1)
        TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items["cupcake-morango"], "add")
    else
        TriggerClientEvent('QBCore:Notify', src, 'You do not have the rigth items...', 'error')
    end
end)

RegisterNetEvent('mt-UwUCafe:server:FazerCupcakeLimao', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local pacoteleite = Player.Functions.GetItemByName('pacote-leite').amount
    local barramanteiga = Player.Functions.GetItemByName('barra-manteiga').amount
    local pacotefarinha = Player.Functions.GetItemByName('pacote-farinha').amount
    local limao = Player.Functions.GetItemByName('limao').amount

    if pacoteleite ~=nil and barramanteiga ~=nil and pacotefarinha ~=nil and caixamorangos ~=nil and limo ~=nil and pacoteleite >=2 and barramanteiga >=2 and pacotefarinha >=2 and limao >=2 then

        Player.Functions.RemoveItem('pacote-leite', 2)
        Player.Functions.RemoveItem('barra-manteiga', 2)
        Player.Functions.RemoveItem('pacote-farinha', 2)
        Player.Functions.RemoveItem('limao', 2)
        Player.Functions.AddItem('cupcake-limao', 1)
        TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items["cupcake-limao"], "add")
    else
        TriggerClientEvent('QBCore:Notify', src, 'You do not have the rigth items...', 'error')
    end
end)

RegisterNetEvent('mt-UwUCafe:server:FazerCupcakeChocolate', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local pacoteleite = Player.Functions.GetItemByName('pacote-leite').amount
    local barramanteiga = Player.Functions.GetItemByName('barra-manteiga').amount
    local pacotefarinha = Player.Functions.GetItemByName('pacote-farinha').amount
    local barrachocolate = Player.Functions.GetItemByName('barra-chocolate').amount

    if pacoteleite ~=nil and barramanteiga ~=nil and pacotefarinha ~=nil and barrachocolate ~=nil  and pacoteleite >=2 and barramanteiga >=2 and pacotefarinha >=2 and barrachocolate >=2 then

        Player.Functions.RemoveItem('pacote-leite', 2)
        Player.Functions.RemoveItem('barra-manteiga', 2)
        Player.Functions.RemoveItem('pacote-farinha', 2)
        Player.Functions.RemoveItem('barra-chocolate', 2)
        Player.Functions.AddItem('cupcake-chocolate', 1)
        TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items["cupcake-chocolate"], "add")
    else
        TriggerClientEvent('QBCore:Notify', src, 'You do not have the rigth items...', 'error')
    end
end)

RegisterNetEvent('mt-UwUCafe:server:FazerGeladoMorango', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local pacotenatas = Player.Functions.GetItemByName('pacote-natas').amount
    local leitecondensado = Player.Functions.GetItemByName('leite-condensado').amount
    local caixamorangos = Player.Functions.GetItemByName('caixa-morangos').amount

    if pacotenatas ~=nil and leitecondensado ~=nil and caixamorangos ~=nil  and pacotenatas >=2 and leitecondensado >=2 and caixamorangos >=2 then

        Player.Functions.RemoveItem('pacote-natas', 2)
        Player.Functions.RemoveItem('leite-condensado', 2)
        Player.Functions.RemoveItem('caixa-morangos', 2)
        Player.Functions.AddItem('gelado-morango', 1)
        TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items["gelado-morango"], "add")
    else
        TriggerClientEvent('QBCore:Notify', src, 'You do not have the rigth items...', 'error')
    end
end)

RegisterNetEvent('mt-UwUCafe:server:FazerGeladoChocolate', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local pacotenatas = Player.Functions.GetItemByName('pacote-natas').amount
    local leitecondensado = Player.Functions.GetItemByName('leite-condensado').amount
    local barrachocolate = Player.Functions.GetItemByName('barra-chocolate').amount

    if pacotenatas ~=nil and leitecondensado ~=nil and barrachocolate ~=nil and pacotenatas >=2 and leitecondensado >=2 and barrachocolate >=2 then

        Player.Functions.RemoveItem('pacote-natas', 2)
        Player.Functions.RemoveItem('leite-condensado', 2)
        Player.Functions.RemoveItem('barra-chocolate', 2)
        Player.Functions.AddItem('gelado-chocolate', 1)
        TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items["gelado-chocolate"], "add")
    else
        TriggerClientEvent('QBCore:Notify', src, 'You do not have the rigth items...', 'error')
    end
end)

RegisterNetEvent('mt-UwUCafe:server:FazerGeladoBaunilha', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local pacotenatas = Player.Functions.GetItemByName('pacote-natas').amount
    local leitecondensado = Player.Functions.GetItemByName('leite-condensado').amount
    local extratobaunilha = Player.Functions.GetItemByName('extrato-baunilha').amount

    if pacotenatas ~=nil and leitecondensado ~=nil and extratobaunilha ~=nil and pacotenatas >=2 and leitecondensado >=2 and extratobaunilha >=2 then

        Player.Functions.RemoveItem('pacote-natas', 2)
        Player.Functions.RemoveItem('leite-condensado', 2)
        Player.Functions.RemoveItem('extrato-baunilha', 2)
        Player.Functions.AddItem('gelado-baunilha', 1)
        TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items["gelado-baunilha"], "add")
    else
        TriggerClientEvent('QBCore:Notify', src, 'You do not have the rigth items...', 'error')
    end
end)

RegisterNetEvent('mt-UwUCafe:server:FazerPanquencaNutela', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local pacotefarinha = Player.Functions.GetItemByName('pacote-farinha').amount
    local pacoteleite = Player.Functions.GetItemByName('pacote-leite').amount
    local pacoteacucar = Player.Functions.GetItemByName('pacote-acucar').amount
    local frasconutela = Player.Functions.GetItemByName('frasco-nutela').amount

    if pacotefarinha~=nil and pacoteleite ~=nil and pacoteacucar ~=nil and frasconutela ~=nil and pacotefarinha >=2 and pacoteleite >=2 and pacoteacucar >=2 and frasconutela >=2 then

        Player.Functions.RemoveItem('pacote-farinha', 2)
        Player.Functions.RemoveItem('pacote-leite', 2)
        Player.Functions.RemoveItem('pacote-acucar', 2)
        Player.Functions.RemoveItem('frasco-nutela', 2)
        Player.Functions.AddItem('panqueca-nutela', 1)
        TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items["panqueca-nutela"], "add")
    else
        TriggerClientEvent('QBCore:Notify', src, 'You do not have the rigth items...', 'error')
    end
end)

RegisterNetEvent('mt-UwUCafe:server:FazerPanquencaOreo', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local pacotefarinha = Player.Functions.GetItemByName('pacote-farinha').amount
    local pacoteleite = Player.Functions.GetItemByName('pacote-leite').amount
    local pacoteacucar = Player.Functions.GetItemByName('pacote-acucar').amount
    local pacoteoreo = Player.Functions.GetItemByName('pacote-oreo').amount

    if pacotefarinha~=nil and pacoteleite ~=nil and pacoteacucar ~=nil and pacoteoreo ~=nil and pacotefarinha >=2 and pacoteleite >=2 and pacoteacucar >=2 and pacoteoreo >=2 then

        Player.Functions.RemoveItem('pacote-farinha', 2)
        Player.Functions.RemoveItem('pacote-leite', 2)
        Player.Functions.RemoveItem('pacote-acucar', 2)
        Player.Functions.RemoveItem('pacote-oreo', 2)
        Player.Functions.AddItem('panqueca-oreo', 1)
        TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items["panqueca-oreo"], "add")
    else
        TriggerClientEvent('QBCore:Notify', src, 'You do not have the rigth items...', 'error')
    end
end)

RegisterNetEvent('mt-UwUCafe:server:FazerMuffinChocolate', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local pacotefarinha = Player.Functions.GetItemByName('pacote-farinha').amount
    local pacoteleite = Player.Functions.GetItemByName('pacote-leite').amount
    local barrachocolate = Player.Functions.GetItemByName('barra-chocolate').amount

    if pacotefarinha~=nil and pacoteleite ~=nil and barrachocolate ~=nil and pacotefarinha >=2 and pacoteleite >=2 and barrachocolate >=2 then

        Player.Functions.RemoveItem('pacote-farinha', 2)
        Player.Functions.RemoveItem('pacote-leite', 2)
        Player.Functions.RemoveItem('barra-chocolate', 2)
        Player.Functions.AddItem('muffin-chocolate', 1)
        TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items["muffin-chocolate"], "add")
    else
        TriggerClientEvent('QBCore:Notify', src, 'You do not have the rigth items...', 'error')
    end
end)

RegisterNetEvent('mt-UwUCafe:server:FazerWaffleNutela', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local pacotefarinha = Player.Functions.GetItemByName('pacote-farinha').amount
    local pacoteleite = Player.Functions.GetItemByName('pacote-leite').amount
    local frasconutela = Player.Functions.GetItemByName('frasco-nutela').amount

    if pacotefarinha~=nil and pacoteleite ~=nil and frasconutela ~=nil and pacotefarinha >=2 and pacoteleite >=2 and frasconutela >=2 then

        Player.Functions.RemoveItem('pacote-farinha', 2)
        Player.Functions.RemoveItem('pacote-leite', 2)
        Player.Functions.RemoveItem('frasco-nutela', 2)
        Player.Functions.AddItem('waffle-nutela', 1)
        TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items["waffle-nutela"], "add")
    else
        TriggerClientEvent('QBCore:Notify', src, 'You do not have the rigth items...', 'error')
    end
end)

RegisterNetEvent('mt-UwUCafe:server:FazerPastelFrango', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local pacotefarinha = Player.Functions.GetItemByName('pacote-farinha').amount
    local barramanteiga = Player.Functions.GetItemByName('barra-manteiga').amount
    local frango = Player.Functions.GetItemByName('frango').amount

    if pacotefarinha~=nil and barramanteiga ~=nil and frango ~=nil and pacotefarinha >=2 and barramanteiga >=2 and frango >=2 then

        Player.Functions.RemoveItem('pacote-farinha', 2)
        Player.Functions.RemoveItem('barra-manteiga', 2)
        Player.Functions.RemoveItem('frango', 2)
        Player.Functions.AddItem('pastel-frango', 1)
        TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items["pastel-frango"], "add")
    else
        TriggerClientEvent('QBCore:Notify', src, 'You do not have the rigth items...', 'error')
    end
end)

---------------------------
------- bebidas -----------

RegisterNetEvent('mt-UwUCafe:server:FazerCafe', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local water_bottle = Player.Functions.GetItemByName('water_bottle').amount
    local graoscafe = Player.Functions.GetItemByName('graos-cafe').amount

    if water_bottle >=2 and graoscafe >=2 then

        Player.Functions.RemoveItem('water_bottle', 2)
        Player.Functions.RemoveItem('graos-cafe', 2)
        Player.Functions.AddItem('cafe-uwu', 1)
        TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items["cafe-uwu"], "add")
    else
        TriggerClientEvent('QBCore:Notify', src, 'You do not have the rigth items...', 'error')
    end
end)

RegisterNetEvent('mt-UwUCafe:server:FazerLatte', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local pacoteleite = Player.Functions.GetItemByName('pacote-leite').amount
    local graoscafe = Player.Functions.GetItemByName('graos-cafe').amount

    if pacoteleite~=nil and graoscafe ~=nil and graoscafe >=2 and pacoteleite >=2 then

        Player.Functions.RemoveItem('pacote-leite', 2)
        Player.Functions.RemoveItem('graos-cafe', 2)
        Player.Functions.AddItem('latte-uwu', 1)
        TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items["latte-uwu"], "add")
    else
        TriggerClientEvent('QBCore:Notify', src, 'You do not have the rigth items...', 'error')
    end
end)

RegisterNetEvent('mt-UwUCafe:server:FazerBubbleTeaAmora', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local water_bottle = Player.Functions.GetItemByName('water_bottle').amount
    local caixaamoras = Player.Functions.GetItemByName('caixa-amoras').amount

    if water_bottle~=nil and caixaamoras ~=nil and water_bottle >=2 and caixaamoras >=2 then

        Player.Functions.RemoveItem('water_bottle', 2)
        Player.Functions.RemoveItem('caixa-amoras', 2)
        Player.Functions.AddItem('bubble-amora', 1)
        TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items["bubble-amora"], "add")
    else
        TriggerClientEvent('QBCore:Notify', src, 'You do not have the rigth items...', 'error')
    end
end)

RegisterNetEvent('mt-UwUCafe:server:FazerBubbleTeaMorango', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local water_bottle = Player.Functions.GetItemByName('water_bottle').amount
    local caixamorangos = Player.Functions.GetItemByName('caixa-morangos').amount

    if water_bottle~=nil and caixaamoras ~=nil and water_bottle >=2 and caixamorangos >=2 then

        Player.Functions.RemoveItem('water_bottle', 2)
        Player.Functions.RemoveItem('caixa-morangos', 2)
        Player.Functions.AddItem('bubble-morango', 1)
        TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items["bubble-morango"], "add")
    else
        TriggerClientEvent('QBCore:Notify', src, 'You do not have the rigth items...', 'error')
    end
end)

RegisterNetEvent('mt-UwUCafe:server:FazerBubbleTeaMenta', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local water_bottle = Player.Functions.GetItemByName('water_bottle').amount
    local extratomenta = Player.Functions.GetItemByName('extrato-menta').amount

    if water_bottle~=nil and extratomenta ~=nil and water_bottle >=2 and extratomenta >=2 then

        Player.Functions.RemoveItem('water_bottle', 2)
        Player.Functions.RemoveItem('extrato-menta', 2)
        Player.Functions.AddItem('bubble-menta', 1)
        TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items["bubble-menta"], "add")
    else
        TriggerClientEvent('QBCore:Notify', src, 'You do not have the rigth items...', 'error')
    end
end)

RegisterNetEvent('mt-UwUCafe:server:FazerMilkshakeChocolate', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local pacoteleite = Player.Functions.GetItemByName('pacote-leite').amount
    local barrachocolate = Player.Functions.GetItemByName('barra-chocolate').amount

    if pacoteleite~=nil and barrachocolate ~=nil and pacoteleite >=2 and barrachocolate >=2 then

        Player.Functions.RemoveItem('pacote-leite', 2)
        Player.Functions.RemoveItem('barra-chocolate', 2)
        Player.Functions.AddItem('milkshake-chocolate', 1)
        TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items["milkshake-chocolate"], "add")
    else
        TriggerClientEvent('QBCore:Notify', src, 'You do not have the rigth items...', 'error')
    end
end)

RegisterNetEvent('mt-UwUCafe:server:FazerMilkshakeMorango', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local pacoteleite = Player.Functions.GetItemByName('pacote-leite').amount
    local caixamorangos = Player.Functions.GetItemByName('caixa-morangos').amount

    if pacoteleite~=nil and caixamorangos ~=nil and pacoteleite >=2 and caixamorangos >=2 then

        Player.Functions.RemoveItem('pacote-leite', 2)
        Player.Functions.RemoveItem('caixa-morangos', 2)
        Player.Functions.AddItem('milkshake-morango', 1)
        TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items["milkshake-morango"], "add")
    else
        TriggerClientEvent('QBCore:Notify', src, 'You do not have the rigth items...', 'error')
    end
end)

----------------------------------------------
------- Tirar dinheiro ingredientes ----------

RegisterNetEvent('mt-UwUCafe:server:Tirar20dolares', function(item,count)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player.Functions.RemoveMoney('bank', 200) then
        TriggerClientEvent('QBCore:Notify', src,"Money Remove from Your Bank", "success")
        Player.Functions.AddItem(item, count)
        TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items[item], "add")
    elseif Player.Functions.RemoveMoney('cash', 200) then
        Player.Functions.AddItem(item, count)
        TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items[item], "add")
        TriggerClientEvent('QBCore:Notify', src,"Money Remove from Your Cash", "success")
    else
        TriggerClientEvent('QBCore:Notify', src,"Not Enough Money", "error")
    end
end)

RegisterNetEvent('mt-UwUCafe:server:Tirar30dolares', function(item,count)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player.Functions.RemoveMoney('bank', 300) then
        TriggerClientEvent('QBCore:Notify', src,"Money Remove from Your Bank", "success")
        Player.Functions.AddItem(item, count)
        TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items[item], "add")
    elseif Player.Functions.RemoveMoney('cash', 300) then
        TriggerClientEvent('QBCore:Notify', src,"Money Remove from Your Cash", "success")
        Player.Functions.AddItem(item, count)
        TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items[item], "add")
    else
        TriggerClientEvent('QBCore:Notify', src,"Not Enough Money", "error")
    end
end)

RegisterNetEvent('mt-UwUCafe:server:Tirar50dolares', function(item,count)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    if Player.Functions.RemoveMoney('bank', 500) then
        TriggerClientEvent('QBCore:Notify', src,"Money Remove from Your Bank", "success")
        Player.Functions.AddItem(item, count)
        TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items[item], "add")
    elseif Player.Functions.RemoveMoney('cash', 500) then
        TriggerClientEvent('QBCore:Notify', src,"Money Remove from Your Cash", "success")
        Player.Functions.AddItem(item, count)
        TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items[item], "add")
    else
        TriggerClientEvent('QBCore:Notify', src,"Not Enough Money", "error")
    end
end)

-----------------------------------------------
-------- Usar Bebidas -------------------------

QBCore.Functions.CreateUseableItem("cafe-uwu", function(source, item)
    local Player = QBCore.Functions.GetPlayer(source)
	if Player.Functions.GetItemBySlot(item.slot) ~= nil then
        TriggerClientEvent('mt-UwUCafe:client:BeberCafe', source)
        Player.Functions.RemoveItem('cafe-uwu', 1)
    end
end)

QBCore.Functions.CreateUseableItem("latte-uwu", function(source, item)
    local Player = QBCore.Functions.GetPlayer(source)
	if Player.Functions.GetItemBySlot(item.slot) ~= nil then
        TriggerClientEvent('mt-UwUCafe:client:BeberLatte', source)
        Player.Functions.RemoveItem('latte-uwu', 1)
    end
end)

QBCore.Functions.CreateUseableItem("bubble-amora", function(source, item)
    local Player = QBCore.Functions.GetPlayer(source)
	if Player.Functions.GetItemBySlot(item.slot) ~= nil then
        TriggerClientEvent('mt-UwUCafe:client:BeberBubbleTea', source)
        Player.Functions.RemoveItem('bubble-amora', 1)
    end
end)

QBCore.Functions.CreateUseableItem("bubble-morango", function(source, item)
    local Player = QBCore.Functions.GetPlayer(source)
	if Player.Functions.GetItemBySlot(item.slot) ~= nil then
        TriggerClientEvent('mt-UwUCafe:client:BeberBubbleTea', source)
        Player.Functions.RemoveItem('bubble-morango', 1)
    end
end)

QBCore.Functions.CreateUseableItem("bubble-menta", function(source, item)
    local Player = QBCore.Functions.GetPlayer(source)
	if Player.Functions.GetItemBySlot(item.slot) ~= nil then
        TriggerClientEvent('mt-UwUCafe:client:BeberBubbleTea', source)
        Player.Functions.RemoveItem('bubble-menta', 1)
    end
end)

QBCore.Functions.CreateUseableItem("milkshake-chocolate", function(source, item)
    local Player = QBCore.Functions.GetPlayer(source)
	if Player.Functions.GetItemBySlot(item.slot) ~= nil then
        TriggerClientEvent('mt-UwUCafe:client:BeberMilkshake', source)
        Player.Functions.RemoveItem('milkshake-chocolate', 1)
    end
end)

QBCore.Functions.CreateUseableItem("milkshake-morango", function(source, item)
    local Player = QBCore.Functions.GetPlayer(source)
	if Player.Functions.GetItemBySlot(item.slot) ~= nil then
        TriggerClientEvent('mt-UwUCafe:client:BeberMilkshake', source)
        Player.Functions.RemoveItem('milkshake-morango', 1)
    end
end)


-------------------------------------------------
--------- Usar Comidas --------------------------

QBCore.Functions.CreateUseableItem("cupcake-morango", function(source, item)
    local Player = QBCore.Functions.GetPlayer(source)
	if Player.Functions.GetItemBySlot(item.slot) ~= nil then
        TriggerClientEvent('mt-UwUCafe:client:ComerCupcake', source)
        Player.Functions.RemoveItem('cupcake-morango', 1)
    end
end)

QBCore.Functions.CreateUseableItem("cupcake-chocolate", function(source, item)
    local Player = QBCore.Functions.GetPlayer(source)
	if Player.Functions.GetItemBySlot(item.slot) ~= nil then
        TriggerClientEvent('mt-UwUCafe:client:ComerCupcake', source)
        Player.Functions.RemoveItem('cupcake-chocolate', 1)
    end
end)

QBCore.Functions.CreateUseableItem("cupcake-limao", function(source, item)
    local Player = QBCore.Functions.GetPlayer(source)
	if Player.Functions.GetItemBySlot(item.slot) ~= nil then
        TriggerClientEvent('mt-UwUCafe:client:ComerCupcake', source)
        Player.Functions.RemoveItem('cupcake-limao', 1)
    end
end)

QBCore.Functions.CreateUseableItem("gelado-morango", function(source, item)
    local Player = QBCore.Functions.GetPlayer(source)
	if Player.Functions.GetItemBySlot(item.slot) ~= nil then
        TriggerClientEvent('mt-UwUCafe:client:ComerGelado', source)
        Player.Functions.RemoveItem('gelado-morango', 1)
    end
end)

QBCore.Functions.CreateUseableItem("gelado-chocolate", function(source, item)
    local Player = QBCore.Functions.GetPlayer(source)
	if Player.Functions.GetItemBySlot(item.slot) ~= nil then
        TriggerClientEvent('mt-UwUCafe:client:ComerGelado', source)
        Player.Functions.RemoveItem('gelado-chocolate', 1)
    end
end)

QBCore.Functions.CreateUseableItem("gelado-baunilha", function(source, item)
    local Player = QBCore.Functions.GetPlayer(source)
	if Player.Functions.GetItemBySlot(item.slot) ~= nil then
        TriggerClientEvent('mt-UwUCafe:client:ComerGelado', source)
        Player.Functions.RemoveItem('gelado-baunilha', 1)
    end
end)

QBCore.Functions.CreateUseableItem("panqueca-nutela", function(source, item)
    local Player = QBCore.Functions.GetPlayer(source)
	if Player.Functions.GetItemBySlot(item.slot) ~= nil then
        TriggerClientEvent('mt-UwUCafe:client:ComerPanqueca', source)
        Player.Functions.RemoveItem('panqueca-nutela', 1)
    end
end)

QBCore.Functions.CreateUseableItem("panqueca-oreo", function(source, item)
    local Player = QBCore.Functions.GetPlayer(source)
	if Player.Functions.GetItemBySlot(item.slot) ~= nil then
        TriggerClientEvent('mt-UwUCafe:client:ComerPanqueca', source)
        Player.Functions.RemoveItem('panqueca-oreo', 1)
    end
end)

QBCore.Functions.CreateUseableItem("muffin-chocolate", function(source, item)
    local Player = QBCore.Functions.GetPlayer(source)
	if Player.Functions.GetItemBySlot(item.slot) ~= nil then
        TriggerClientEvent('mt-UwUCafe:client:ComerMuffin', source)
        Player.Functions.RemoveItem('muffin-chocolate', 1)
    end
end)

QBCore.Functions.CreateUseableItem("waffle-nutela", function(source, item)
    local Player = QBCore.Functions.GetPlayer(source)
	if Player.Functions.GetItemBySlot(item.slot) ~= nil then
        TriggerClientEvent('mt-UwUCafe:client:ComerWaffle', source)
        Player.Functions.RemoveItem('waffle-nutela', 1)
    end
end)

QBCore.Functions.CreateUseableItem("pastel-frango", function(source, item)
    local Player = QBCore.Functions.GetPlayer(source)
	if Player.Functions.GetItemBySlot(item.slot) ~= nil then
        TriggerClientEvent('mt-UwUCafe:client:ComerPastel', source)
        Player.Functions.RemoveItem('pastel-frango', 1)
    end
end)

------------------------------------------------
---------- Faturar Player ----------------------

RegisterServerEvent("mt-UwUCafe:server:FaturarPlayer")
AddEventHandler("mt-UwUCafe:server:FaturarPlayer", function(playerId, amount)
        local biller = QBCore.Functions.GetPlayer(source)
        local billed = QBCore.Functions.GetPlayer(tonumber(playerId))
        local amount = tonumber(amount)
        if biller.PlayerData.job.name == 'uwu' then
            if billed ~= nil then
                if biller.PlayerData.citizenid ~= billed.PlayerData.citizenid then
                    if amount and amount > 0 then
                        MySQL.Async.execute('INSERT INTO phone_invoices (citizenid, amount, society, sender, sendercitizenid) VALUES (@citizenid, @amount, @society, @sender, @sendercitizenid)', {
                            ['@citizenid'] = billed.PlayerData.citizenid,
                            ['@amount'] = amount,
                            ['@society'] = biller.PlayerData.job.name,
                            ['@sender'] = biller.PlayerData.charinfo.firstname,
                            ['@sendercitizenid'] = biller.PlayerData.citizenid
                        })
                        TriggerClientEvent('qb-phone:RefreshPhone', billed.PlayerData.source)
                        TriggerClientEvent('QBCore:Notify', source, 'Invoice Successfully Sent', 'success')
                        TriggerClientEvent('QBCore:Notify', billed.PlayerData.source, 'New Invoice Received')
                    else
                        TriggerClientEvent('QBCore:Notify', source, 'Must be a number above 0', 'error')
                    end
                else
                    TriggerClientEvent('QBCore:Notify', source, 'You can not bill yourself...', 'error')
                end
            else
                TriggerClientEvent('QBCore:Notify', source, 'The player is not online', 'error')
            end
        else
            TriggerClientEvent('QBCore:Notify', source, 'No access', 'error')
        end
end)


RegisterNetEvent('qb-uwu:shop:server', function()
    
	local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player.PlayerData.job.name == "uwu" and Player.PlayerData.job.grade.level == 4 then
        
        TriggerClientEvent('mt-UwUCafe:client:MenuLoja', src)

    else
        TriggerClientEvent('QBCore:Notify', source, "Looks like you Cant Access this part", "error")
    end
end)

RegisterNetEvent('mt-UwUCafe:server:FrigorificoIngredients', function()
    
	local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player.PlayerData.job.name == "uwu" and Player.PlayerData.job.grade.level == 4 then
        
        TriggerClientEvent('mt-UwUCafe:client:FrigorificoIngredients', src)

    else
        TriggerClientEvent('QBCore:Notify', source, "Looks like you Cant Access this part", "error")
    end
end)


