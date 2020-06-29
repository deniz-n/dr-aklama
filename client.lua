----   ____    ____         ----
----  /\  _`\ /\  _`\       ----
----  \ \ \/\ \ \ \L\ \     ----
----   \ \ \ \ \ \ ,  /     ----
----    \ \ \_\ \ \ \\ \    ----
----     \ \____/\ \_\ \_\  ----
----      \/___/  \/_/\/ /  ----

ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
        Citizen.Wait(5)

		TriggerEvent("esx:getSharedObject", function(library)
			ESX = library
		end)
    end

    if ESX.IsPlayerLoaded() then
		ESX.PlayerData = ESX.GetPlayerData()

    end
end)

RegisterNetEvent("esx:playerLoaded")
AddEventHandler("esx:playerLoaded", function(response)
	ESX.PlayerData = response
end)

RegisterNetEvent("esx:setJob")
AddEventHandler("esx:setJob", function(response)
	ESX.PlayerData["job"] = response
end)

Citizen.CreateThread(function()
	Citizen.Wait(100)

	while true do
		local ped = PlayerPedId()
		local pedCoords = GetEntityCoords(ped)
		local dstCheck = GetDistanceBetweenCoords(pedCoords, Config.Zone.Coord.x, Config.Zone.Coord.y, Config.Zone.Coord.z, true)

		if not Config.onlyrealestateagent or (Config.onlyrealestateagent and ESX.PlayerData["job"] and ESX.PlayerData["job"]["name"] == "realestateagent") then

			if dstCheck <= 5.0 then
				sleepThread = 5

				local text = "Para Aklama"

				if dstCheck <= 0.7 then
					text = "Para aklamaya başlamak için [~g~E~s~] Tuşuna bas."

					if IsControlJustPressed(0, 38) then
						TriggerServerEvent('dr:aklama')
					end
				end

				ESX.Game.Utils.DrawText3D(Config.Zone.Coord, text, 0.6)
			end
		end
			if dstCheck >= 8.50 then
				Citizen.Wait(3000)
			else
				Citizen.Wait(5)
			end
	end
end)