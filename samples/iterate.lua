-- loading the module
local queue = require("queue")

-- creating a queue instance
local q = queue()

-- adding elements to it
q:enqueue(10)
q:enqueue("dog")

-- iterating elements
for pos, value in q:iterate() do
    -- pos holds the element's position in the queue
    -- value holds the element's value
    print(pos, value)
end