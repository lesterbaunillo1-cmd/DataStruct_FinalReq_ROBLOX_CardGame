local TeleportService = game:GetService("TeleportService")
local teleportPart = workspace:WaitForChild("TeleportPad")  
local arenaID = 131232726849353  -- replace with YOUR ID

teleportPart.Touched:Connect(function(hit)
	local plr = game.Players:GetPlayerFromCharacter(hit.Parent)
	if plr then
		TeleportService:TeleportAsync(arenaID, {plr})
	end
end)
