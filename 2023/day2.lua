local stringx = require("pl.stringx")
stringx.import()

local Game = {}
Game.__index = Game

function Game:get_id(str)
	return tonumber(stringx.replace(str, "Game ", ""))
end

function Game:get_rounds(str)
	-- { 1: {red: 2, green: 2}, 2: {blue: 99} }
	local rounds = {
		totals = {
			red = 0,
			green = 0,
			blue = 0,
		},
		maximums = {
			red = 0,
			green = 0,
			blue = 0,
		},
		draws = {},
	}

	-- 2 red, 2 green; 6 red, 6 green 2 blue;
	for i, v in pairs(stringx.split(str, ";")) do
		rounds.draws[i] = { red = 0, green = 0, blue = 0 }
		local round = stringx.strip(v)
		-- 2 red, 2 green
		for _, v in pairs(stringx.split(round, ",")) do
			-- 2 red
			local draw = stringx.strip(v):split(" ")
			local number = tonumber(draw[1])
			local color = draw[2]

			-- update total
			rounds.totals[color] = rounds.totals[color] + number

			-- update minimums
			rounds.maximums[color] = math.max(rounds.maximums[color], number)

			-- update draws
			rounds.draws[i][color] = number
		end
	end

	return rounds
end

-- Game 1: 2 red, 2 green; 6 red, 3 green; 2 red, 1 green, 2 blue; 1 red
function Game.new(str)
	local self = setmetatable({}, Game)
	local id_part = stringx.split(str, ":")[1]
	local rounds_part = stringx.strip(stringx.split(str, ":")[2])

	self.id = self:get_id(id_part)
	self.rounds = self:get_rounds(rounds_part)

	return self
end

local function part1(l)
	local game = Game.new(l)
	local is_possible = true

	local draws = game.rounds.draws
	for i = 1, #draws do
		if draws[i].red > 12 or draws[i].green > 13 or draws[i].blue > 14 then
			is_possible = false
		end
	end

	if is_possible then
		return game.id
	end
	return 0
end

local function part2(l)
	local game = Game.new(l)
	local maxmimums = game.rounds.maximums
	return (maxmimums.red * maxmimums.green * maxmimums.blue)
end

local function run(filename, func)
	local val = 0
	for l in io.lines(filename) do
		val = val + func(l)
	end
	return val
end

print("Part 1 - " .. run("./data/day2.txt", part1))
print("Part 2 - " .. run("./data/day2.txt", part2))
