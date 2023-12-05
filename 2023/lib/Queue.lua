local Queue = {}
Queue.__index = Queue

-- B,A
function Queue.new()
	local self = setmetatable({
		q = {},
		head = 0,
		tail = -1,
		length = 0,
	}, Queue)
	return self
end

function Queue:enqueu(item)
	local tail = self.tail + 1
	self.tail = tail
	self.q[tail] = item
	self.length = self.length + 1
end

function Queue:dequeue()
	if self:is_empty() then
		return nil
	end

	local head = self.head + 1
	local item = self.q[self.head]
	self.q[self.head] = nil
	self.head = head
	self.length = self.length - 1
	return item
end

function Queue:len()
	return self.length
end

function Queue:is_empty()
	return self.length == 0
end

return Queue
