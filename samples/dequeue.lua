-- loading the module
local queue = require("queue")

-- creating a queue instance
local q = queue()

-- adding elements to it
q:enqueue(10)
q:enqueue("dog")

local v1 = q:dequeue() -- remove 10 from the queue and store on v1 variable
local v2 = q:dequeue() -- remove "dog" from the queue and store on v2 variable

print(v1) -- print 10
print(v2) -- print "dog"