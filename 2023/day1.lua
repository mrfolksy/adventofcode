local common = require("lib.common")

local filename = "data/day1.txt"

local word_as_number = {
	one = 1,
	two = 2,
	three = 3,
	four = 4,
	five = 5,
	six = 6,
	seven = 7,
	eight = 8,
	nine = 9,
}

function part1(line)
	local nums = {}
	for i = 1, #line do
		local c = string.sub(line, i, i)
		if string.match(c, "%d") then
			nums[#nums + 1] = c
		end
	end
	return tonumber(nums[1] .. nums[#nums])
end

function part2(line)
	local maxi = 1
	-- a table of k -> v where k is the index of the value v in the string
	-- where a 'number' word appears the index is the start of the word
	-- e.g in string 1foothree5
	-- 1 -> 1, 5 -> 3, 10 -> 5
	local nums = {}

	for i = 1, #line do
		-- search for 'words' that are numbers
		-- this is a bit inefficiant because we may find the same work in the same location multiple times
		for k, v in pairs(word_as_number) do
			local s, _ = line:find(k, i)
			if s then
				nums[s] = v
				maxi = math.max(maxi, s)
			end
		end

		-- search for 'numbers' check the first digit is a number
		local x = string.match(line:sub(i, i), "%d")
		if x then
			nums[i] = x
			maxi = math.max(maxi, i)
		end
	end

	local keys = common.get_keys(nums)
	table.sort(keys)

	return tonumber(nums[keys[1]] .. nums[keys[#keys]])
end

function apply(filename, fun)
	local val = 0
	for line in io.lines(filename) do
		val = val + fun(line)
	end
	return val
end

print("Part 1 " .. apply(filename, part1))
print("Part 2 " .. apply(filename, part2))
