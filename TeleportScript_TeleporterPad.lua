local teleportPart = script.Parent
local seatsFolder = teleportPart:WaitForChild("SeatsFolder")

local playersOnPad = {}
local countdown = 0
local countdownRunning = false

local MIN_PLAYERS = 2
local MAX_PLAYERS = 4

local ui = teleportPart:WaitForChild("TeleportUI")
local status = ui.Status
local playerCountLabel = ui.PlayerCount
local countdownLabel = ui.Countdown

local function updateUI()
	local count = #playersOnPad

	playerCountLabel.Text = count .. "/" .. MAX_PLAYERS

	if count < MIN_PLAYERS then
		status.Text = "Waiting for players..."
		countdownLabel.Text = ""
	else
		status.Text = "Teleporting soon..."
	end
end

local function beginCountdown()
	if countdownRunning then return end
	countdownRunning = true
	countdown = 10

	while countdown > 0 do
		local count = #playersOnPad

		if count < MIN_PLAYERS then
			countdownLabel.Text = ""
			countdownRunning = false
			return
		end

		countdownLabel.Text = "Teleporting in: " .. countdown
		task.wait(1)
		countdown -= 1
	end

	-- Teleport players
	local seats = seatsFolder:GetChildren()

	for i, player in ipairs(playersOnPad) do
		local char = player.Character
		if char and seats[i] then
			char:PivotTo(seats[i].CFrame)
		end
	end

	countdownRunning = false
end

teleportPart.Touched:Connect(function(hit)
	local player = game.Players:GetPlayerFromCharacter(hit.Parent)
	if not player then return end

	if not table.find(playersOnPad, player) then
		table.insert(playersOnPad, player)
		updateUI()
	end

	if #playersOnPad >= MIN_PLAYERS and not countdownRunning then
		beginCountdown()
	end
end)

teleportPart.TouchEnded:Connect(function(hit)
	local player = game.Players:GetPlayerFromCharacter(hit.Parent)
	if not player then return end

	local index = table.find(playersOnPad, player)
	if index then
		table.remove(playersOnPad, index)
		updateUI()
	end
end)
