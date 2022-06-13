-- loading the module
local queue = require("queue")

-- creating a queue instance
local q = queue()

-- adding elements to it
q:enqueue(10)

print(q.count) -- 1 will show up

-- adding elements to it
q:enqueue("dog")

print(q.count) -- 2 will show up