local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CardsFolder = ReplicatedStorage:WaitForChild("CardImages")

local DealEvent = Instance.new("RemoteEvent")
DealEvent.Name = "DealCardsEvent" -- FIXED
DealEvent.Parent = ReplicatedStorage:WaitForChild("RemoteEvents")

local TOTAL_CARDS = 8

local function DealToPlayer(player)
	local cards = {}
	local allCards = CardsFolder:GetChildren()

	for i = 1, TOTAL_CARDS do
		local randomCard = allCards[math.random(1, #allCards)]
		table.insert(cards, randomCard.Name)
	end

	DealEvent:FireClient(player, cards)
end

game.Players.PlayerAdded:Connect(function(player)
	player.CharacterAdded:Connect(function()
		task.wait(3)
		DealToPlayer(player)
	end)
end)
