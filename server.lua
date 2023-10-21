-------------------------
--- BadgerBankRobbery ---
-------------------------
--- Server ---


robberyActive = false
RegisterNetEvent('BadgerBankRobbery:IsActive')
AddEventHandler('BadgerBankRobbery:IsActive', function()
	-- Check if active or not
	if robberyActive then
		-- One is active
		TriggerClientEvent('BadgerBankRobbery:IsActive:Return', source, true)
	else
		-- One is not active
		TriggerClientEvent('BadgerBankRobbery:IsActive:Return', source, false)
	end
end)

RegisterServerEvent("BadgerBankRobbery.getIsAllowed")
AddEventHandler("BadgerBankRobbery.getIsAllowed", function()
    local source = source -- Retrieve the source from the event argument
    if source and IsPlayerAceAllowed(source, "badgerbank.rob") then
        TriggerClientEvent("BadgerBankRobbery.returnIsAllowed", source, true)
    else
        TriggerClientEvent("BadgerBankRobbery.returnIsAllowed", source, false)
    end
end)


NDCore = exports["ND_Core"]:GetCoreObject()

RegisterNetEvent('BadgerBankRobbery:SetActive')
AddEventHandler('BadgerBankRobbery:SetActive', function(bool)
	robberyActive = bool
	if bool then
		Wait((1000 * 60 * config.robberyCooldown))
		robberyActive = false
	end
end)

RegisterNetEvent('BadgerBankRobbery:SetStoreActive')
AddEventHandler('BadgerBankRobbery:SetStoreActive', function(bool)
	robberyActive = bool
	if bool then
		Wait((1000 * 60 * config.robberyStoreCooldown))
		robberyActive = false
	end
end)

RegisterNetEvent('Print:PrintDebug')
AddEventHandler('Print:PrintDebug', function(msg)
	print(msg)
	TriggerClientEvent('chatMessage', -1, "^7[^1Badger's Scripts^7] ^1DEBUG ^7" .. msg)
end)
RegisterNetEvent('PrintBR:PrintMessage')
AddEventHandler('PrintBR:PrintMessage', function(msg)
	TriggerClientEvent('chatMessage', -1, msg)
end)

RegisterNetEvent("Bank:Finished", function()
    local src = source
	NDCore.Functions.AddMoney(config.amount, src, "cash")
end)

RegisterNetEvent("Store:Finished", function()
    local src = source
	NDCore.Functions.AddMoney(config.storeAmount, src, "cash")
end)