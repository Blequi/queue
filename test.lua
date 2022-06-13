require("busted.runner")()

local Queue = require("queue")

describe("module loading", function()
    it("should not be null", function()
        assert.are_not.equals(nil, Queue)
    end)

    it("should return a function", function()
        assert.are.equals("function", type(Queue))
    end)
end)

describe("queue initialization", function()
    it("should not be null", function()
        assert.are_not.equals(nil, Queue())
    end)

    it("should start with count as zero", function()
        local q = Queue()
        assert.are.equals(0, q.count)
    end)
end)

describe("queue fields", function()
    it("should be read-only", function()
        local q = Queue()

        q:enqueue(math.random())
        q:enqueue(math.random())

        local any_field = 'a' .. tostring(math.random(1, 10))

        assert.False(pcall(function() q[any_field] = 2 end))
        assert.False(pcall(function() q.count = 2 end))
        assert.False(pcall(function() q.first = 2 end))
        assert.False(pcall(function() q.last = 2 end))
    end)
end)

-- methods

describe("clear method", function()
    it("should set count to zero on queues with arbitrary number of elements", function()
        local q = Queue()

        local n = math.random(5, 10)

        for i = 1, n do
            q:enqueue(math.random())
        end

        q:clear()

        assert.are.equals(0, q.count)
    end)

    it("should not have any elements to iterate", function()
        local q = Queue()

        local n = math.random(5, 10)

        for i = 1, n do
            q:enqueue(math.random())
        end

        q:clear()
        
        for pos, v in q:iterate() do
            assert.True(false)
        end
    end)
end)

describe("dequeue method", function()
    it("should throw error if queue is empty", function()
        local q = Queue()

        assert.False(pcall(function() q:dequeue() end))
    end)

    it("should decrement count from one to zero", function()    
        local q = Queue()
        q:enqueue(math.random())
        assert.are.equals(1, q.count)

        local deq = q:dequeue()
        assert.are.equals(0, q.count)
    end)

    it("should decrement count from n to n - 1", function()    
        local q = Queue()
        
        local n = math.random(5, 10)

        for i = 1, n do
            q:enqueue(math.random())
        end

        assert.are.equals(n, q.count)

        q:dequeue()

        assert.are.equals(n - 1, q.count)
    end)

    it("should return the first enqueued element on empty fresh queues", function()    
        local q = Queue()

        local first = math.random()
        q:enqueue(first)
        assert.are.equals(1, q.count)

        local n = math.random(5, 10)

        for i = 1, n do
            q:enqueue(math.random())
        end

        assert.are.equals(first, q:dequeue())
    end)

    it("should return the second enqueued element on queues holding a single element", function()    
        local q = Queue()

        local first = math.random()
        q:enqueue(first)
        assert.are.equals(1, q.count)

        local second = math.random()
        q:enqueue(second)
        assert.are.equals(2, q.count)

        local n = math.random(5, 10)

        for i = 1, n do
            q:enqueue(math.random())
        end

        assert.are.equals(first, q:dequeue())
        assert.are.equals(second, q:dequeue())
    end)
end)

describe("iterate method", function()
    it("should not iterate any element on fresh empty queues", function()
        local q = Queue()

        assert.True(q:empty())

        for pos, v in q:iterate() do
            assert.True(false)
        end
    end)

    it("should iterate once on queues holding a single element", function()
        local q = Queue()

        assert.True(q:empty())

        q:enqueue(math.random())

        assert.are.equals(1, q.count)

        local n = q.count

        local i = 0
        for pos, v in q:iterate() do
            if (i > 0) then
                assert.True(false)
            end

            i = i + 1
        end
    end)

    it("should iterate at most n times on queues holding n element", function()
        local q = Queue()

        for j = 1, 10 do

            q:clear()

            local n = j

            for i = 1, n do
                q:enqueue(math.random())
            end

            assert.are.equals(n, q.count)

            local k = 0
            for pos, v in q:iterate() do
                if (k > n) then
                    assert.True(false)
                end
    
                k = k + 1
            end
        end

    end)

    it("should iterate exactly as a table on queues holding n element", function()
        local q = Queue()

        for j = 1, 10 do

            q:clear()

            local n = j

            local t = {}

            for i = 1, n do
                local e = math.random()

                table.insert(t, e)
                q:enqueue(e)
            end

            assert.are.equals(n, q.count)

            for pos, v in q:iterate() do
                assert.are.equals(t[pos], v)                
            end
        end
    end)
end)

describe("empty method", function()
    it("should return true for fresh empty queues", function()
        local q = Queue()

        assert.True(q:empty())
    end)

    it("should return false for queues with n number of elements", function()
        local q = Queue()
        
        for j = 1, 10 do
            q:clear()

            assert.are.equals(0, q.count)
            
            local n = j

            for i = 1, n do
                q:enqueue(math.random())
            end

            assert.False(q:empty())
        end
    end)

    it("should return true after removing any element for queues with a single element", function()
        local q = Queue()
        
        q:enqueue(math.random())

        assert.are.equals(1, q.count)
        assert.False(q:empty())

        q:dequeue()

        assert.True(q:empty())
    end)

    it("should return true after removing n elements for queues with n number of elements", function()
        local q = Queue()
        
        for j = 1, 10 do
            q:clear()

            assert.are.equals(0, q.count)
            
            local n = j

            for i = 1, n do
                q:enqueue(math.random())
            end

            assert.False(q:empty())

            for i = 1, n do
                q:dequeue()
            end

            assert.True(q:empty())
        end
    end)

    it("should return true after clearing queues with n number of elements", function()
        local q = Queue()
        
        for j = 1, 10 do
            q:clear()

            assert.are.equals(0, q.count)
            
            local n = j

            for i = 1, n do
                q:enqueue(math.random())
            end

            assert.False(q:empty())

            q:clear()

            assert.True(q:empty())
        end
    end)
end)

describe("enqueue method", function()
    it("should increment count from zero to one on empty fresh queues", function()    
        local q = Queue()
        q:enqueue(math.random())
        assert.are.equals(1, q.count)
    end)

    it("should increment count from zero to one on empty cleared queues", function()    
        local q = Queue()
        
        local n = math.random(5, 10)
        for i = 1, n do
            q:enqueue(math.random())
        end

        q:clear()

        assert.are.equals(0, q.count)

        q:enqueue(math.random())
        assert.are.equals(1, q.count)
    end)
    
    it("should increment count from n to n + 1 on queues with n number of elements", function()        
        local q = Queue()
        
        local n = math.random(5, 10)

        for i = 1, n do
            q:enqueue(math.random())

            assert.are.equals(i, q.count)
        end
    end)

    it("should increment count from zero to one adding integer on empty fresh queues", function()    
        local q = Queue()
        q:enqueue(math.random(1, 100))
        assert.are.equals(1, q.count)
    end)

    it("should increment count from zero to one adding integer on empty cleared queues", function()    
        local q = Queue()
        
        local n = math.random(5, 10)
        for i = 1, n do
            q:enqueue(math.random(1, 100))
        end

        q:clear()

        assert.are.equals(0, q.count)

        q:enqueue(math.random(1, 100))
        assert.are.equals(1, q.count)
    end)
    
    it("should increment count from n to n + 1 adding integer on queues with n number of elements", function()        
        local q = Queue()
        
        local n = math.random(5, 10)

        for i = 1, n do
            q:enqueue(math.random(1, 100))

            assert.are.equals(i, q.count)
        end
    end)
    
    it("should increment count from zero to one adding nil on empty fresh queues", function()    
        local q = Queue()
        q:enqueue(nil)
        assert.are.equals(1, q.count)
    end)

    it("should increment count from zero to one adding nil on empty cleared queues", function()    
        local q = Queue()
        
        local n = math.random(5, 10)
        for i = 1, n do
            q:enqueue(nil)
        end

        q:clear()

        assert.are.equals(0, q.count)

        q:enqueue(nil)
        assert.are.equals(1, q.count)
    end)
    
    it("should increment count from n to n + 1 adding nil on queues with n number of elements", function()        
        local q = Queue()
        
        local n = math.random(5, 10)

        for i = 1, n do
            q:enqueue(nil)

            assert.are.equals(i, q.count)
        end
    end)

    it("should increment count from zero to one adding function on empty fresh queues", function()    
        local q = Queue()
        q:enqueue(function() end)
        assert.are.equals(1, q.count)
    end)

    it("should increment count from zero to one adding function on empty cleared queues", function()    
        local q = Queue()
        
        local n = math.random(5, 10)
        for i = 1, n do
            q:enqueue(function() end)
        end

        q:clear()

        assert.are.equals(0, q.count)

        q:enqueue(function() end)
        assert.are.equals(1, q.count)
    end)
    
    it("should increment count from n to n + 1 adding function on queues with n number of elements", function()        
        local q = Queue()
        
        local n = math.random(5, 10)

        for i = 1, n do
            q:enqueue(function() end)

            assert.are.equals(i, q.count)
        end
    end)

    it("should increment count from zero to one adding random string on empty fresh queues", function()    
        local q = Queue()
        q:enqueue(tostring(math.random()))
        assert.are.equals(1, q.count)
    end)

    it("should increment count from zero to one adding random string on empty cleared queues", function()    
        local q = Queue()
        
        local n = math.random(5, 10)
        for i = 1, n do
            q:enqueue(tostring(math.random()))
        end

        q:clear()

        assert.are.equals(0, q.count)

        q:enqueue(tostring(math.random()))
        assert.are.equals(1, q.count)
    end)
    
    it("should increment count from n to n + 1 adding random string on queues with n number of elements", function()        
        local q = Queue()
        
        local n = math.random(5, 10)

        for i = 1, n do
            q:enqueue(tostring(math.random()))

            assert.are.equals(i, q.count)
        end
    end)

    it("should increment count from zero to one adding false on empty fresh queues", function()    
        local q = Queue()
        q:enqueue(false)
        assert.are.equals(1, q.count)
    end)

    it("should increment count from zero to one adding false on empty cleared queues", function()    
        local q = Queue()
        
        local n = math.random(5, 10)
        for i = 1, n do
            q:enqueue(false)
        end

        q:clear()

        assert.are.equals(0, q.count)

        q:enqueue(false)
        assert.are.equals(1, q.count)
    end)
    
    it("should increment count from n to n + 1 adding false on queues with n number of elements", function()        
        local q = Queue()
        
        local n = math.random(5, 10)

        for i = 1, n do
            q:enqueue(false)

            assert.are.equals(i, q.count)
        end
    end)

    it("should increment count from zero to one adding true on empty fresh queues", function()    
        local q = Queue()
        q:enqueue(true)
        assert.are.equals(1, q.count)
    end)

    it("should increment count from zero to one adding true on empty cleared queues", function()    
        local q = Queue()
        
        local n = math.random(5, 10)
        for i = 1, n do
            q:enqueue(true)
        end

        q:clear()

        assert.are.equals(0, q.count)

        q:enqueue(true)
        assert.are.equals(1, q.count)
    end)
    
    it("should increment count from n to n + 1 adding true on queues with n number of elements", function()        
        local q = Queue()
        
        local n = math.random(5, 10)

        for i = 1, n do
            q:enqueue(true)

            assert.are.equals(i, q.count)
        end
    end)

    it("should increment count from zero to one adding table on empty fresh queues", function()    
        local q = Queue()
        q:enqueue({})
        assert.are.equals(1, q.count)
    end)

    it("should increment count from zero to one adding table on empty cleared queues", function()    
        local q = Queue()
        
        local n = math.random(5, 10)
        for i = 1, n do
            q:enqueue({})
        end

        q:clear()

        assert.are.equals(0, q.count)

        q:enqueue({})
        assert.are.equals(1, q.count)
    end)
    
    it("should increment count from n to n + 1 adding table on queues with n number of elements", function()        
        local q = Queue()
        
        local n = math.random(5, 10)

        for i = 1, n do
            q:enqueue({})

            assert.are.equals(i, q.count)
        end
    end)
end)

describe("peek method", function()
    it("should throw error if queue is empty", function()
        local q = Queue()

        assert.False(pcall(function() q:peek() end))
    end)

    it("should not decrease count on queues holding n > 0 elements", function()
        local q = Queue()

        for j = 1, 10 do
            q:clear()

            assert.are.equals(0, q.count)

            local n = j

            for i = 1, n do
                q:enqueue(math.random())
            end

            local p = q:peek()

            assert.are.equals(n, q.count)
        end
    end)

    it("should return first element on queues holding n > 0 elements", function()
        local q = Queue()

        for j = 1, 10 do
            q:clear()

            assert.are.equals(0, q.count)

            local n = j
            
            local first = math.random()

            q:enqueue(first)

            assert.are.equals(1, q.count)

            for i = 1, n - 1 do
                q:enqueue(math.random())
            end

            local p = q:peek()

            assert.are.equals(n, q.count)

            assert.are.equals(first, p)
        end
    end)
end)