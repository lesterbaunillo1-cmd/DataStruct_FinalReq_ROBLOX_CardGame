game.Players.PlayerAdded:Connect(function(player)
	player.CharacterAdded:Connect(function(char)
		local humanoid = char:WaitForChild("Humanoid")

		-- Prevent walking & jumping
		humanoid.WalkSpeed = 0
		humanoid.JumpPower = 0
	end)
end)
