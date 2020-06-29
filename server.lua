----   ____    ____         ----
----  /\  _`\ /\  _`\       ----
----  \ \ \/\ \ \ \L\ \     ----
----   \ \ \ \ \ \ ,  /     ----
----    \ \ \_\ \ \ \\ \    ----
----     \ \____/\ \_\ \_\  ----
----      \/___/  \/_/\/ /  ---- 

ESX = nil

TriggerEvent('esx:getSharedObject', function(obj)
	ESX = obj
end)

RegisterServerEvent('dr:aklama')
AddEventHandler('dr:aklama', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local accountMoney = xPlayer.getAccount('black_money').money
	print(accountMoney)
		if accountMoney == 0 then
			if Config.SendAlert then
				TriggerClientEvent('mythic_notify:client:SendAlert', _source, { type = 'error', text = 'Yeterli Kara Paran Yok.', length = 5000 })
			else
				TriggerClientEvent('mythic_notify:client:DoHudText', _source, { type = 'error', text = 'Yeterli Kara Paran Yok.', length = 5000 })
			end
		else
			xPlayer.removeAccountMoney('black_money', accountMoney)
			xPlayer.addMoney(accountMoney / Config.kacabol)
			if Config.SendAlert then
				TriggerClientEvent('mythic_notify:client:SendAlert', _source, { type = 'inform', text = 'Parayı Akladın.', length = 5000 })
			else
				TriggerClientEvent('mythic_notify:client:DoHudText', _source, { type = 'inform', text = 'Parayı Akladın.', length = 5000 })
			end
		end
end)