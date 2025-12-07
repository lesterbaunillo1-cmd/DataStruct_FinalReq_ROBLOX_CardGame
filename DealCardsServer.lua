local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local CardsFolder = ReplicatedStorage:WaitForChild("Cards")
local DealEvent = ReplicatedStorage:WaitForChild("RemoteEvents"):WaitForChild("DealCards")
local SitEvent = ReplicatedStorage:WaitForChild("SitEvent")  

local seatedPlayers = {}

-- Create & Shuffle Deck
local function CreateDeck()
	local deck = {}
	for _, card in ipairs(CardsFolder:GetChildren()) do
		table.insert(deck, card.Name)
	end

	for i = #deck, 2, -1 do
		local j = math.random(1, i)
		deck[i], deck[j] = deck[j], deck[i]
	end

	return deck
end

-- Deal 8 cards to every player
local function DealToPlayers()
	local deck = CreateDeck()

	for _, player in ipairs(Players:GetPlayers()) do
		local hand = {}

		for i = 1, 8 do  
			local cardName = table.remove(deck, 1)
			table.insert(hand, cardName)
		end

		DealEvent:FireClient(player, hand)
	end

end

-- When a player sits down, mark them as ready
SitEvent.OnServerEvent:Connect(function(player)
	seatedPlayers[player] = true

	-- Check if ALL players are seated
	local allSeated = true

	for _, p in ipairs(Players:GetPlayers()) do
		if not seatedPlayers[p] then
			allSeated = false
		end
	end

	-- If everyone is seated ? DEAL CARDS
	if allSeated then
		DealToPlayers()
	end
end)
