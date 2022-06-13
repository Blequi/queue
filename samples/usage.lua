-- loading the module
local queue = require("queue")

-- creating a queue instance
local q = queue()

-- adding elements to it
q:enqueue(10)
q:enqueue("dog")
q:enqueue(nil)
q:enqueue(function() print("hello world") end)

-- print the number of elements in the queue
print(q.count)

-- iterating elements
for pos, value in q:iterate() do
    -- pos holds the element's position in the queue
    -- value holds the element's value
    print(pos, value)
end

-- dequeue elements from the queue
local v1 = q:dequeue() -- 10 will be removed
local v2 = q:dequeue() -- "dog" will be removed
local v3 = q:dequeue() -- nil will be removed
local v4 = q:dequeue() -- `function() print("hello world") end` will be removed