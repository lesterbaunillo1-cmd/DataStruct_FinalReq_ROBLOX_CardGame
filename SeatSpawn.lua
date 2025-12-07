local seatsFolder = workspace:WaitForChild("Seats")

game.Players.PlayerAdded:Connect(function(player)
	player.CharacterAdded:Connect(function(char)

		local humanoid = char:WaitForChild("Humanoid")
		local hrp = char:WaitForChild("HumanoidRootPart")

		-- pick a seat based on joining order
		local allSeats = seatsFolder:GetChildren()
		local seatIndex = (#game.Players:GetPlayers() % #allSeats) + 1
		local seat = allSeats[seatIndex]

		-- teleport player above the seat
		hrp.CFrame = seat.CFrame + Vector3.new(0, 2, 0)

		-- rotate character to face same direction as seat
		hrp.CFrame = CFrame.new(
			hrp.Position,
			hrp.Position + seat.CFrame.LookVector
		)

		-- force sit
		task.wait(0.1)
		humanoid.Sit = true
	end)
end)
