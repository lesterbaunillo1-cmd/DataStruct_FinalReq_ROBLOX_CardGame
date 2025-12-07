local ReplicatedStorage = game:GetService("ReplicatedStorage")
local SitEvent = ReplicatedStorage:WaitForChild("SitEvent")

SitEvent.OnClientEvent:Connect(function(seat)
	local character = game.Players.LocalPlayer.Character
	if not character then return end

	local hum = character:WaitForChild("Humanoid")

	task.wait(0.2)
	hum.Sit = true
end)
