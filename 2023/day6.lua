local function part1(races)
	local res = 1
	for _, race in ipairs(races) do
		local wins = 0
		for x = 1, race.t do
			y = x * (race.t - x)
			if y > race.dst then
				wins = wins + 1
			end
		end
		res = res * wins
	end
	return res
end

local function part2(race)
	local xlow = 0
	for x = 1, race.t do
		local y = x * (race.t - x)
		if y > race.dst then
			xlow = x
			break
		end
	end

	local xhigh = 0
	for x = race.t, 1, -1 do
		local y = x * (race.t - x)
		if y > race.dst then
			xhigh = x
			break
		end
	end

	return (xhigh - xlow) + 1
end

-- Time:        45     97     72     95
-- Distance:   305   1062   1110   1695
local races_p1 = {
	{ t = 45, dst = 305 },
	{ t = 97, dst = 1062 },
	{ t = 72, dst = 1110 },
	{ t = 95, dst = 1695 },
}

local races_p2 = {
	t = 45977295,
	dst = 305106211101695,
}

print("Part 1 - " .. part1(races_p1))
print("Part 2 - " .. part2(races_p2))
