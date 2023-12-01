local common = require("lib.common")

local numbers = {
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

local function part1(line)
	local nums = {}
	for i = 1, #line do
		local c = string.sub(line, i, i)
		if string.match(c, "%d") then
			nums[#nums + 1] = c
		end
	end
	return tonumber(nums[1] .. nums[#nums])
end

local function part2(line)
	local nums = {}

	for i = 1, #line do
		-- search for 'numbers' check the first digit is a number
		local x = string.match(line:sub(i, i), "%d")
		if x then
			nums[#nums + 1] = x
		else
			-- search for 'words' that are numbers
			for k, v in pairs(numbers) do
				-- only check if the substring starting at index matches a 'number' word
				local s, _ = line:find("^" .. k, i)
				if s then
					nums[#nums + 1] = v
				end
			end
		end
	end

	return tonumber(nums[1] .. nums[#nums])
end

local function apply(filename, fun)
	local val = 0
	for line in io.lines(filename) do
		val = val + fun(line)
	end
	return val
end

local filename = "data/day1.txt"
print("Part 1 " .. apply(filename, part1))
print("Part 2 " .. apply(filename, part2))
