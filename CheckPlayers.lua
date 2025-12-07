local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local PlayerLoaded = ReplicatedStorage:WaitForChild("PlayerLoaded")
local AllPlayersReady = ReplicatedStorage:WaitForChild("AllPlayersReady")

local readyPlayers = {}

PlayerLoaded.OnServerEvent:Connect(function(player)
	readyPlayers[player.UserId] = true

	-- Check if all current players are ready
	for _, plr in ipairs(Players:GetPlayers()) do
		if not readyPlayers[plr.UserId] then
			return
		end
	end

	-- If everyone is ready ? notify all clients
	AllPlayersReady:FireAllClients()
end)
