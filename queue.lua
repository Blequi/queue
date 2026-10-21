-- The MIT License (MIT)
--
-- Copyright (c) 2022 - 2026 Blequi https://github.com/Blequi/queue
--
-- Permission is hereby granted, free of charge,
-- to any person obtaining a copy of this software
-- and associated documentation files (the "Software"),
-- to deal in the Software without restriction, including without
-- limitation the rights to use, copy, modify, merge, publish,
-- distribute, sublicense, and/or sell copies of the Software,
-- and to permit persons to whom the Software is furnished to do so,
-- subject to the following conditions:
--
-- The above copyright notice and this permission notice
-- shall be included in all copies or substantial portions
-- of the Software.
--
-- THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
-- EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
-- OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
-- IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE
-- FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
-- ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
-- OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
-- DEALINGS IN THE SOFTWARE.

local version = "0.0.2"

local function iterator(self)
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
        version = version,
        first = nil,
        last = nil,

        -- methods
        clear = function(self) clear(data) end,
        dequeue = function(self) return dequeue(data) end,
        empty = function(self) return empty(data) end,
        enqueue = function(self, value) enqueue(data, value) end,
        iterate = function(self) return iterator(data) end,
        iterator = function(self) return iterator(data) end,
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
