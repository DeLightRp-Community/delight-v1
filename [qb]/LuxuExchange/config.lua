Config = {}

Config.UseCommandToOpenMenu = true --[[ Use command to open menu, true or false ]]

Config.OpenExchangeCMD = "cex" --[[ Command name to open the Crypto Exchange ]]

-- TRANSLATION SECTION
-- You can simply change the values to your own language 
-- This affects the transaction history

Config.Buy = "Buy"
Config.Sell = "Sell"
Config.Transfer = "Transfer"
Config.Price = "Price"
Config.Self = "Self"

-- notifications
-- Important, keep the spaces.

Config.notifyBuySuccess = "You bought "
Config.notifySellSuccess = "You sold "
Config.notifyTransferSuccess = "You sent "

Config.notifyBuyError = "Not enough funds"
Config.notifySellError = "Not enough "
Config.notifyTransferError = "User not found!"
Config.notifyTransferError2 = "You don't have enough funds!"






Config.Date = "%d-%m-%Y %H:%M:%S"  -- Change the looks of the date stored in Transactions database


--[[ TriggerEvent to open the menu: "LuxuGGExchange:openMenu" ]]


--[[ EXPORTS

exports['LuxuExchange']:AddCrypto(playerIdentifier, crypto, ammount) -- adds crypto
exports['LuxuExchange']:RemoveCrypto(playerIdentifier, crypto, ammount) --removes crypto
]]