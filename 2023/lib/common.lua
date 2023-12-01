local M = {}

function M.get_keys(tab)
	local keys = {}
	for k, _ in pairs(tab) do
		keys[#keys + 1] = k
	end
	return keys
end

return M
