local stringx = require("pl.stringx")
local Set = require("pl.Set")
local Queue = require("lib.Queue")

local ScratchCard = {}
ScratchCard.__index = ScratchCard

function ScratchCard.new(str)
	local self = setmetatable({}, ScratchCard)

	local number_parts = stringx.split(str:sub(10, -1), "|")
	self.card_id = str:match("%d+")
	self.card_numbers = Set(stringx.split(stringx.strip(number_parts[1])))
	self.chosen_numbers = Set(stringx.split(stringx.strip(number_parts[2])))
	self.winning_numbers = Set.intersection(self.chosen_numbers, self.card_numbers)
	self.total_winning_numbers = Set.len(self.winning_numbers)
	self.is_winning_card = self.total_winning_numbers > 0
	return self
end

function ScratchCard:get_score()
	if self.is_winning_card then
		return math.pow(2, Set.len(self.winning_numbers - 1))
	else
		return 0
	end
end

---
local function part1(filename)
	local val = 0
	for l in io.lines(filename) do
		local c = ScratchCard.new(l)
		val = val + c:get_score()
	end
	return val
end

local function part2(filename)
	local val = 0
	local cards = {}
	local queue = Queue.new()

	-- read all cards
	for l in io.lines(filename) do
		local c = ScratchCard.new(l)
		cards[tostring(c.card_id)] = c
		queue:enqueue(c)
	end

	-- start counting total number of cards
	while true do
		if not queue:is_empty() then
			local c = queue:dequeue()
			val = val + 1

			-- if c is a winning card enqueue clones
			if c.is_winning_card then
				for i = (c.card_id + 1), (c.card_id + c.total_winning_numbers) do
					local card_to_enqueue = cards[tostring(i)]

					-- checks that we've not gone off the end of the table
					if card_to_enqueue then
						queue:enqueue(card_to_enqueue)
					end
				end
			end
		else
			break
		end
	end

	return val
end

print("Part 1 - " .. part1("data/day4.txt"))
print("Part 2 - " .. part2("data/day4.txt"))
