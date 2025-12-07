local CardData = {}

CardData.Deck = {
	-- Aces (4 suits × 2 pairs)
	{id="Hearts_A1", suit="Hearts", type="Ace"},
	{id="Hearts_A2", suit="Hearts", type="Ace"},

	{id="Spades_A1", suit="Spades", type="Ace"},
	{id="Spades_A2", suit="Spades", type="Ace"},

	{id="Diamonds_A1", suit="Diamonds", type="Ace"},
	{id="Diamonds_A2", suit="Diamonds", type="Ace"},

	{id="Clubs_A1", suit="Clubs", type="Ace"},
	{id="Clubs_A2", suit="Clubs", type="Ace"},
}

-- Number Cards (2–9)
local suits = {"Hearts", "Spades", "Diamonds", "Clubs"}

for _, suit in ipairs(suits) do
	for number = 2, 9 do
		table.insert(CardData.Deck, {
			id = suit .. "_" .. number,
			suit = suit,
			type = "Number",
			value = number
		})
	end
end

-- Face Cards
local faces = {"J", "Q", "K"}

for _, suit in ipairs(suits) do
	for _, face in ipairs(faces) do
		table.insert(CardData.Deck, {
			id = suit .. "_" .. face,
			suit = suit,
			type = "Face",
			face = face
		})
	end
end

-- Joker
table.insert(CardData.Deck, {
	id = "Joker",
	type = "Joker"
})

return CardData
