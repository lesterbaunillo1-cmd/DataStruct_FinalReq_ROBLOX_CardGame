local player = game.Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()

-- Hide head accessories so POV is clear
for _, accessory in pairs(char:GetChildren()) do
	if accessory:IsA("Accessory") then
		-- Check if it's attached to the HEAD
		local handle = accessory:FindFirstChild("Handle")
		if handle and handle:FindFirstChild("AccessoryWeld") then
			local weld = handle:FindFirstChild("AccessoryWeld")
			if weld.Part1.Name == "Head" then
				accessory:Destroy()  -- Remove only for LOCAL PLAYER
			end
		end
	end
end
