local Players = game:GetService("Players")
local player = Players.LocalPlayer

player.CharacterAdded:Connect(function(char)
	local humanoid = char:WaitForChild("Humanoid")

	-- Lock movement entirely
	humanoid.WalkSpeed = 0
	humanoid.JumpPower = 0
	humanoid.JumpHeight = 0
	humanoid.AutoJumpEnabled = false

	-- When character loads, wait a bit for seat to attach
	task.wait(0.3)

	-- If seated, lock them down
	if humanoid.SeatPart then
		humanoid.Sit = true
		humanoid.PlatformStand = true
	end

	-- IF they try to stand up (SeatPart becomes nil), force them back to sitting
	humanoid:GetPropertyChangedSignal("Sit"):Connect(function()
		if humanoid.Sit == false then
			humanoid.Sit = true
		end
	end)

	-- IF they try to unseat (SeatPart removed), re-seat them
	humanoid:GetPropertyChangedSignal("SeatPart"):Connect(function()
		if humanoid.SeatPart == nil then
			humanoid.Sit = true
		end
	end)
end)
