local filename = "data/day1.txt"

function parse(line)
	local ints = {}
	for i = 1, #line do
		local c = string.sub(line, i, i)
		if string.match(c, "%d") then
			ints[#ints + 1] = c
		end
	end
	return tonumber(ints[1] .. ints[#ints])
end

local calibration1 = 0
for line in io.lines(filename) do
	calibration1 = calibration1 + parse(line)
end

-- Part 1
print("Part 1 " .. calibration1)
