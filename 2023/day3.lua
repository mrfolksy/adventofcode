local stringx = require("pl.stringx")
local tablex = require("pl.tablex")
local Set = require("pl.Set")

stringx.import()

local function is_number(s)
	return s:match("%d") ~= nil
end

local function is_symbol(s)
	return (not is_number(s) and s ~= ".")
end

local function is_gear(s)
	return s == "*"
end
-- . . . . .
-- . 1 2 3 .
-- . . * . .
local matrix = {} -- the matrix (lol) of all '.' 'symbols' and 'numbers'
local numbers = {} -- arrary of numbers found along with their index in matrix [{number=n, x=n, y=n}]
local gears = {} -- array of gears found along with their index in the matrix [{x=n,y=n}]

local function parse_data()
	local rowi = 1
	for l in io.lines("data/day3.txt") do
		row = {}
		local coli = 1
		while coli <= #l do
			local c = l:sub(coli, coli)
			-- parse number
			if is_number(c) then
				local n = l:match("%d+", coli)
				numbers[#numbers + 1] = { n = tonumber(n), x = rowi, y = coli }
				for i = 1, #n do
					row[#row + 1] = n
					coli = coli + 1
				end
			elseif is_gear(c) then
				gears[#gears + 1] = { x = rowi, y = coli }
				row[#row + 1] = c
				coli = coli + 1
			else
				row[#row + 1] = c
				coli = coli + 1
			end
		end
		--
		matrix[#matrix + 1] = row
		rowi = rowi + 1
	end
end

local function part1()
	local val = 0
	for _, v in pairs(numbers) do
		local n = v.n
		-- . . . . .
		-- . 1 2 3 .
		-- . . . . .
		local to_sum = false
		for x = v.x - 1, v.x + 1 do -- 1 row above and below
			for y = v.y - 1, v.y + #tostring(n) do -- 1 column before and after (numbers can be 1-n chars long)
				-- make sure we are 'in' the matrix (lols), i.e don't pick an x and y that is not a valid index
				if x >= 1 and x <= #matrix and y >= 1 and y <= #matrix[x] then
					if is_symbol(matrix[x][y]) then
						to_sum = true
					end
				end
			end
		end
		if to_sum then
			val = val + n
		end
	end
	return val
end

local function part2()
	local val = 0
	for _, v in pairs(gears) do
		local nums = Set({}) -- using a set to capture unique numbers
		-- . . .
		-- . * .
		-- . . .
		for x = v.x - 1, v.x + 1 do -- 1 row above and below
			for y = v.y - 1, v.y + 1 do -- 1 col before and after
				-- make sure we are 'in' the matrix (lols), i.e don't pick an x and y that is not a valid index
				if x >= 1 and x <= #matrix and y >= 1 and y <= #matrix[x] then
					if is_number(matrix[x][y]) then
						nums = nums + matrix[x][y]
					end
				end
			end
		end
		-- add values if exactly 2
		if Set.len(nums) == 2 then
			local t = tablex.keys(nums)
			val = val + (t[1] * t[2])
		end
	end
	return val
end

parse_data()
print("Part 1 - " .. part1())
print("Part 2 - " .. part2())
