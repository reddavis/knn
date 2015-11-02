
require 'algorithms'
require 'pry'

class FixedLengthQueue < Containers::PriorityQueue
  def initialize(limit = 4) # 4 for example
    super()
    @min_priority
    @max_priority
    @limit = limit
  end

  def push(value, priority)
    if size < @limit
      super(value, priority)
    else
      if priority < @heap.next_key
        pop
        super(value, priority)
      end
    end
  end

  def dump()
    size.times.map{ @heap.pop }
  end
end
