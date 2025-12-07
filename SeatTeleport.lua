local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TeleportEvent = ReplicatedStorage:WaitForChild("TeleportToArenaEvent")

local SeatsFolder = workspace:WaitForChild("ArenaSeats")

-- Collect seats safely
local seatList = {}

for _, model in ipairs(SeatsFolder:GetChildren()) do
	local seat = model:FindFirstChildWhichIsA("Seat")
	if seat then
		table.insert(seatList, seat)
	end
end

-- Sort seats (Seat1, Seat2, etc.)
table.sort(seatList, function(a, b)
	return tonumber(a.Parent.Name:match("%d+")) < tonumber(b.Parent.Name:match("%d+"))
end)

local nextSeat = 1

TeleportEvent.OnServerEvent:Connect(function(player)
	local character = player.Character
	if not character then return end

	local humanoid = character:WaitForChild("Humanoid")
	local hrp = character:WaitForChild("HumanoidRootPart")

	local seat = seatList[nextSeat]
	if not seat then
		warn("NO SEAT FOUND!")
		return
	end

	-- Prevent walking/jumping
	humanoid.WalkSpeed = 0
	humanoid.JumpPower = 0
	humanoid.JumpHeight = 0

	-- Teleport exactly on seat
	character:PivotTo(seat.CFrame)

	task.wait(0.1)
	humanoid.Sit = true

	nextSeat += 1
end)
