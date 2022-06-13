-- loading the module
local queue = require("queue")

-- creating a queue instance
local q = queue()

print(q:empty()) -- prints true

-- adding elements to it
q:enqueue(10)
q:enqueue("dog")

print(q:empty()) -- prints false