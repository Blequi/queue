# queue

## Table of Contents

* [Summary](#summary)
* [Description](#description)
* [Installation](#installation)
* [Usage](#usage)
* [Properties](#properties)
    * [count](#count)
* [Methods](#methods)
    * [clear](#clear)
    * [dequeue](#dequeue)
    * [empty](#empty)
    * [enqueue](#enqueue)
    * [iterate](#iterate)
    * [peek](#peek)
* [Unit Tests](#unit-tests)
* [Code Coverage](#code-coverage)

## Summary

**queue** data structure written in pure Lua

## Description

In computer science, queue is a data structure operating on elements in a FIFO (first in, first out) manner. In other words, the first element added to the queue will be the first one to be removed.

Even though there are common possibilities to implement a queue, this module employs a linked list implementation written in pure Lua.

## Installation

*  If luarocks is available on your operating system, just issue the command:
```
[sudo] luarocks install queue
```

* Simply drop the *queue.lua* file on your project path and ```require("queue")``` it.

## Usage

```lua
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
```

## Properties

### count

* *Description*: the number of elements in the queue
* *Signature*: ```count```
    * *return (integer)*
* *Example*:
```lua
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
```

## Methods

### clear

* *Description*: removes all the elements from the queue
* *Signature*: ```clear()```
    * *return (void)*
* *Example*:
```lua
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
```

### dequeue

* *Description*: pops the first element from the queue
* *Signature*: ```dequeue()```
    * *return (object)*
* *Example*:
```lua
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
```

### empty

* *Description*: verifies the absence of elements in the queue
* *Signature*: ```empty()```
    * *return (boolean)*
* *Example*:
```lua
-- loading the module
local queue = require("queue")

-- creating a queue instance
local q = queue()

print(q:empty()) -- prints true

-- adding elements to it
q:enqueue(10)
q:enqueue("dog")

print(q:empty()) -- prints false
```

### enqueue

* *Description*: pushes an element into the queue
* *Signature*: ```enqueue(value)```
    * *value*: element to push into the queue
    * *return (void)*
* *Example*:
```lua
-- loading the module
local queue = require("queue")

-- creating a queue instance
local q = queue()

-- adding elements to it
q:enqueue(10)
q:enqueue("dog")

print(q.count) -- 2 will be printed
```

### iterate

* *Description*: iterates the queue
* *Signature*: ```iterate()```
    * *return (function)*
* *Example*:
```lua
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
```

### peek

* *Description*: peeks an element from the first position in the queue, but does not remove it
* *Signature*: ```peek()```
    * *return (object)*
* *Example*:
```lua
-- loading the module
local queue = require("queue")

-- creating a queue instance
local q = queue()

-- adding elements to it
q:enqueue(10)

print(q.count) -- prints 1

local v1 = q:peek() -- v1 holds 10

print(q.count) -- peek does not remove elements, so 1 is still printed
print(v1) -- prints 10

-- adding more elements
q:enqueue("dog")

print(q.count) -- prints 2

local v2 = q:peek() -- v2 still holds 10, because elements were not removed

print(q.count) -- peek does not remove elements, so 2 is still printed
print(v2) -- prints 10
```

## Unit Tests

In order to run the unit tests, you need the following development dependencies:

* ```busted```
```
luarocks install busted
```

After ```busted``` installation, open a terminal (or command prompt) in the **queue** directory and run:
```
lua test.lua
```

## Code Coverage

Since *queue* is a tiny library, one primary goal is the achievement of high code coverage running unit tests. Currently, *queue* version 0.0.1-0 achieves 100% code coverage.

In order to run the code coverage on tests, you need ```busted``` library and also the following development dependencies:

* ```luacov```
```
luarocks install luacov
```
* ```luacov-multiple```
```
luarocks install luacov-multiple
```

After ```luacov``` and ```luacov-multiple``` installation, open a terminal (or command prompt) in the **queue** directory and run:

```
lua -lluacov test.lua
```

Once the program finished, navigate to directory ```output > coverage > report``` and open ```index.html``` file on your browser to analyze the code coverage report.