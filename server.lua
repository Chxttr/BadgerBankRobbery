-------------------------
--- BadgerBankRobbery ---
-------------------------
--- Server ---

ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

robberyActive = false

RegisterNetEvent('BadgerBankRobbery:IsActive')
AddEventHandler('BadgerBankRobbery:IsActive', function()
	if robberyActive then
		TriggerClientEvent('BadgerBankRobbery:IsActive:Return', source, true)
	else
		TriggerClientEvent('BadgerBankRobbery:IsActive:Return', source, false)
	end
end)

ESX.RegisterServerCallback('BadgerBankRobbery:canRobShop', function(source, cb, store)
    local cops = 0
    local xPlayers = ESX.GetPlayers()
    for i = 1, #xPlayers do
        local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
        if xPlayer.job.name == 'police' then
            cops = cops + 1
        end
	end
	
    if cops >= config.ShopCops then
		if not robberyActive then
            cb(true)
        else
            cb(false)
        end
    else
        cb('no_cops')
    end
end)

ESX.RegisterServerCallback('BadgerBankRobbery:canRobBank', function(source, cb, store)
    local cops = 0
    local xPlayers = ESX.GetPlayers()
    for i = 1, #xPlayers do
        local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
        if xPlayer.job.name == 'police' then
            cops = cops + 1
        end
	end
	
    if cops >= config.BankCops then
		if not robberyActive then
            cb(true)
        else
            cb(false)
        end
    else
        cb('no_cops')
    end
end)

ESX.RegisterServerCallback('BadgerBankRobbery:canRobAmmu', function(source, cb, store)
    local cops = 0
    local xPlayers = ESX.GetPlayers()
    for i = 1, #xPlayers do
        local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
        if xPlayer.job.name == 'police' then
            cops = cops + 1
        end
	end
	
    if cops >= config.AmmuCops then
		if not robberyActive then
            cb(true)
        else
            cb(false)
        end
    else
        cb('no_cops')
    end
end)

RegisterNetEvent('BadgerBankRobbery:SetActive')
AddEventHandler('BadgerBankRobbery:SetActive', function(bool)
	robberyActive = bool
	if bool then
		Wait((1000 * 60 * config.robberyCooldown)) -- Wait 15 minutes
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

RegisterNetEvent('BadgerBankRobbery:finishbank')
AddEventHandler('BadgerBankRobbery:finishbank', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local reward = config.BankReward

	if config.BlackReward then
		xPlayer.addAccountMoney('black_money', reward)
	else
		xPlayer.addMoney(reward)
	end
end)

RegisterNetEvent('BadgerBankRobbery:finishammu')
AddEventHandler('BadgerBankRobbery:finishammu', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local reward = config.AmmuReward

	if config.BlackReward then
		xPlayer.addAccountMoney('black_money', reward)
	else
		xPlayer.addMoney(reward)
	end
end)

RegisterNetEvent('BadgerBankRobbery:finishstore')
AddEventHandler('BadgerBankRobbery:finishstore', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local reward = config.ShopReward

	if config.BlackReward then
		xPlayer.addAccountMoney('black_money', reward)
	else
		xPlayer.addMoney(reward)
	end
end)