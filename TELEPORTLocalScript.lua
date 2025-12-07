local ui = script.Parent
local status = ui.Status
local playerCount = ui.PlayerCount
local countdown = ui.Countdown
local event = ui.Parent.Parent.UpdateUI

local maxPlayers = 4

event.OnClientEvent:Connect(function(action, data)
	if action == "updateCount" then
		local count = 0
		for _ in pairs(data) do count += 1 end
		playerCount.Text = count.."/4 Players"

		if count < 2 then
			status.Text = "Waiting for Players..."
			countdown.Text = ""
		end

	elseif action == "startCountdown" then
		status.Text = "Starting Soon..."

	elseif action == "count" then
		countdown.Text = "Teleporting in "..data.."…"

	elseif action == "cancel" then
		status.Text = "Waiting for Players..."
		countdown.Text = ""

	elseif action == "reset" then
		status.Text = "Waiting for Players..."
		playerCount.Text = "0/4 Players"
		countdown.Text = ""
	end
end)
