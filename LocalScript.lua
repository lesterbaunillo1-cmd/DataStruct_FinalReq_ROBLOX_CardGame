local TeleportPad = workspace:WaitForChild("TeleportPad")
local RemoteEvent = TeleportPad:WaitForChild("UpdateUI")

local gui = script.Parent:WaitForChild("TeleportUI")
local statusText = gui:WaitForChild("Status")
local playerCountText = gui:WaitForChild("PlayerCount")
local countdownText = gui:WaitForChild("Countdown")

gui.Enabled = true

RemoteEvent.OnClientEvent:Connect(function(mode, value)
	if mode == "COUNTDOWN" then
		statusText.Text = "Teleporting Soon..."
		countdownText.Text = value .. "s"
	else
		if mode == "RESET" then
			statusText.Text = "Waiting for Players"
			playerCountText.Text = "0 / 4"
			countdownText.Text = ""
		else
			statusText.Text = "Waiting for Players"
			playerCountText.Text = mode .. " / " .. value
			countdownText.Text = ""
		end
	end
end)
