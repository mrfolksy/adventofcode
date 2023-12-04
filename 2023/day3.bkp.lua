local stringx = require("pl.stringx")
stringx.import()

local filename = "data/day3.txt"

local symbols = {} -- 0 -> "*" -> "x-y"
local numbers = {} -- 0 -> "x-y" -> X

local function is_number(s)
	return s:match("%d") ~= nil
end

local function get_index(x, y)
	return x .. "-" .. y
end

local function gen_neighbourhood(x, y)
	return {
		--
		get_index(x - 1, y - 1),
		get_index(x, y - 1),
		get_index(x + 1, y - 1),
		--
		get_index(x - 1, y),
		get_index(x + 1, y),
		--
		get_index(x - 1, y + 1),
		get_index(x, y + 1),
		get_index(x + 1, y + 1),
	}
end

local x = 1
for l in io.lines(filename) do
	local y = 1
	local i = 1
	while i <= #l do
		-- parse number
		if is_number(l:sub(i, i)) then
			local _, e = l:sub(i, -1):find("%d+")
			local n = tonumber(l:sub(i, i + (e - 1)))
			---
			numbers[tonumber(n)] = get_index(x, y)
			i = i + e
		end

		-- parse symbol
		if l:sub(i, i) ~= "." then
			symbols[get_index(x, y)] = l:sub(i, i)
		end

		y = y + 1
		i = i + 1
	end
	x = x + 1
end

local val = 0
for k, v in pairs(numbers) do
	local x = tonumber(v:split("-")[1])
	local y = tonumber(v:split("-")[2])
	local neighbours = gen_neighbourhood(x, y)
	for _, v in pairs(neighbours) do
		if symbols[v] then
			val = val + k
		end
	end
end

print("Part 1 - " .. val)
