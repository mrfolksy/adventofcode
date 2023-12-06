local Queue = {}
Queue.__index = Queue

function Queue.new()
	local self = setmetatable({
		t = {},
		head = 0,
		tail = -1,
		length = 0,
	}, Queue)
	return self
end

function Queue:enqueue(item)
	local tail = self.tail + 1
	self.tail = tail
	self.t[tail] = item
	self.length = self.length + 1
end

function Queue:dequeue()
	if self:is_empty() then
		return nil
	end

	local head = self.head + 1
	local item = self.t[self.head]
	self.t[self.head] = nil
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
