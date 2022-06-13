local function iterate(self)
    local node = self.first
    local position = 0

    local iter = function()
        if (node == nil) then
            return nil
        end

        local res = node.value

        node = node.next
        position = position + 1

        return position, res
    end

    return iter
end

local function enqueue(self, value)
    local node = {
        next = nil,
        value = value
    }

    local count = self.count

    if (count > 0) then
        self.last.next = node
    else
        self.first = node
    end

    self.last = node
    self.count = count + 1
end

local function dequeue(self)
    local count = self.count
    assert(count > 0, "Queue is empty")

    local head = self.first

    if (count == 1) then
        self.first = nil
        self.last = nil
    else
        self.first = head.next
    end

    self.count = count - 1

    return head.value
end

local function peek(self)
    assert(self.count > 0, "Queue is empty")
    return self.first.value
end

local function empty(self)
    return self.count == 0
end

local function clear(self)
    self.count = 0
    self.first = nil
    self.last = nil
end

local function create()
    local data = nil
    data = {
        -- properties
        count = 0,
        first = nil,
        last = nil,

        -- methods
        clear = function(self) clear(data) end,
        dequeue = function(self) return dequeue(data) end,
        empty = function(self) return empty(data) end,
        enqueue = function(self, value) enqueue(data, value) end,
        iterate = function(self) return iterate(data) end,
        peek = function(self) return peek(data) end
    }

    return setmetatable(
        {}, {
            __index = data,
            __newindex = function(self, key, value)
                error("This object is read-only")
            end,
            __metatable = false
        }
    )
end

return create