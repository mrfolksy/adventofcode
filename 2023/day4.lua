local stringx = require("pl.stringx")
local Set = require("pl.Set")

local ScratchCard = {}
ScratchCard.__index = ScratchCard

function ScratchCard.new(str)
	local self = setmetatable({}, ScratchCard)

	self.card_number = str:match("%d+")

	local number_parts = stringx.split(str:sub(10, -1), "|")

	self.winning_numbers = stringx.strip(number_parts[1])
	self.chosen_numbers = stringx.strip(number_parts[2])

	return self
end

function ScratchCard:get_score()
	local winning_set = Set(stringx.split(self.winning_numbers))
	local chosen_set = Set(stringx.split(self.chosen_numbers))

	local intersection = Set.intersection(chosen_set, winning_set)
	if Set.len(intersection) == 0 then
		return 0
	else
		return math.pow(2, Set.len(intersection) - 1)
	end
end

local val = 0
for l in io.lines("data/day4.txt") do
	local scratchcard = ScratchCard.new(l)
	val = val + scratchcard:get_score()
end

print("Part 1 - " .. val)
