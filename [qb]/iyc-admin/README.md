# qb-core/server/functions.lua
## dont bother this is old
```lua
QBCore.Functions.GetPlayerFromIdentifier = function(Identifier)
	for src, player in pairs(QBCore.Players) do
		if Identifier ~= nil then
            if QBCore.Players[src].PlayerData.license == Identifier then
                return QBCore.Players[src]
            end            
        end
	end
	return nil
end
```