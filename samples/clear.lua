-- loading the module
local queue = require("queue")

-- creating a queue instance
local q = queue()

-- adding elements to it
q:enqueue(10)
q:enqueue("dog")

print(q.count) -- 2 will be printed

-- clearing the queue
q:clear()

print(q.count) -- 0 will be printed