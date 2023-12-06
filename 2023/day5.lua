local stringx = require("pl.stringx")
local Queue = require("lib.Queue")
stringx.import()

local function transform(val, map)
	return map.dst + (val - map.src)
end

local function get_location(maps, seed)
	local loc = seed
	for _, mappings in pairs(maps) do
		for _, map in pairs(mappings.maps) do
			if loc >= map.src and loc <= map.src + map.rng then
				loc = transform(loc, map)
				break
			end
		end
	end
	return loc
end

local function initialise(filename)
	local maps = {} -- { i -> {name = "name of map:", dst = x, src=y, rng=z}}
	local seeds = {} -- list of seeds
	local current_map = nil
	for l in io.lines(filename) do
		if l ~= "" then
			-- initialise seeds
			if l:startswith("seeds: ") then
				seeds = l:sub(8, -1):split()
			elseif l:endswith("map:") then
				-- dst src range
				current_map = { name = l, maps = {} }
				maps[#maps + 1] = current_map
			else
				local mappings = l:split()
				local maps = current_map.maps
				maps[#maps + 1] = {
					dst = tonumber(mappings[1]),
					src = tonumber(mappings[2]),
					rng = tonumber(mappings[3]),
				}
			end
		end
	end

	for i = 1, #seeds do
		seeds[i] = tonumber(seeds[i])
	end

	return maps, seeds
end

local function part1(maps, seeds)
	local res = nil
	for _, seed in pairs(seeds) do
		local loc = get_location(maps, seed)
		if res then
			res = math.min(loc, res)
		else
			res = loc
		end
	end
	return res
end

local function part2(maps, seeds)
	-- create a queue of pairs of seeds start to end range
	local seedsq = Queue.new()
	for i = 1, #seeds, 2 do
		seedsq:enqueue({ s = seeds[i], e = (seeds[i] + seeds[i + 1]) })
	end

	-- for each mapping block
	for _, mappings in pairs(maps) do
		-- create a new output queue, this will contain transformed seeds
		local outq = Queue.new()

		-- while current seedq has items search for mappings
		while not seedsq:is_empty() do
			local seed = seedsq:dequeue()
			local s, e = seed.s, seed.e
			-- for seed find a mapping that applies
			local is_mapping_found = false
			for _, map in pairs(mappings.maps) do
				local a, b = map.src, map.src + map.rng
				local x, y = math.max(s, a), math.min(e, b)
				-- in the case of no overlap the above will cause x > y
				if x < y then
					-- apply transform to range and enqueue
					outq:enqueue({ s = transform(x, map), e = transform(y, map) })

					-- add the remaining chunks, these need to go through the mappings to see if they are applied
					-- s....e
					-- |--a.....b
					--    x.y
					if x > s then
						seedsq:enqueue({ s = s, e = x })
					end
					--   s.....e
					-- a....b
					--   x..y--|
					if e > y then
						seedsq:enqueue({ s = y, e = e })
					end
					is_mapping_found = true
					break -- mapping + remainders dealt with, move to next seed
				end
			end
			-- if no overlap found in block, append seed as is, no transform applied
			if not is_mapping_found then
				outq:enqueue(seed)
			end
		end
		--- now move onto the next block - pass in transformed seeds
		seedsq = outq
	end

	local res = nil
	while not seedsq:is_empty() do
		local seed = seedsq:dequeue()
		if res ~= nil then
			res = math.min(res, seed.s)
		else
			res = seed.s
		end
	end

	return res
end

maps, seeds = initialise("data/day5.txt")
print("Part 1 - " .. part1(maps, seeds))
print("Part 2 - " .. part2(maps, seeds))
