local stringx = require("pl.stringx")
stringx.import()

local function is_number(s)
	return s:match("%d") ~= nil
end

local function is_symbol(s)
	return (not is_number(s) and s ~= ".")
end

-- . . . . .
-- . 1 2 3 .
-- . . * . .
local matrix = {} -- the matrix (lol) of all '.' 'symbols' and 'numbers'
local numbers = {} -- arrary of numbers found along with their index in matrix [{number=n, x=n, y=n}]

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
				row[#row + 1] = n:sub(i, i)
				coli = coli + 1
			end
		else
			row[#row + 1] = c
			coli = coli + 1
		end
	end
	--
	matrix[#matrix + 1] = row
	rowi = rowi + 1
end

local val = 0
for _, v in pairs(numbers) do
	local n = v.n
	-- . . . . .
	-- . 1 2 3 .
	-- . . . . .
	local to_sum = false
	for x = v.x - 1, v.x + 1 do -- 1 row above and below
		for y = v.y - 1, v.y + #tostring(n) do -- 1 column before and after
			-- make sure we are in the matrix (lol), i.e don't pick an x and y that is not a valid index
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

print("Part 1 - " .. val)
