-- loading the module
local queue = require("queue")

-- creating a queue instance
local q = queue()

-- adding elements to it
q:enqueue(10)

print(#q) -- prints 1

local v1 = q:peek() -- v1 holds 10

print(#q) -- peek does not remove elements, so 1 is still printed
print(v1) -- prints 10

-- adding more elements
q:enqueue("dog")

print(#q) -- prints 2

local v2 = q:peek() -- v2 still holds 10, because elements were not removed

print(#q) -- peek does not remove elements, so 2 is still printed
print(v2) -- prints 10
