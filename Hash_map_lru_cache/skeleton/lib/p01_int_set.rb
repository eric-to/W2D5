class MaxIntSet
  def initialize(max)
    @store = Array.new(max) { false }
    
  end

  def insert(num)
    @store[num] = true if is_valid?(num)
  end

  def remove(num)
    @store[num] = false
  end

  def include?(num)
    @store[num]
  end

  private

  def is_valid?(num)
    raise "Out of bounds" unless num.between?(0, @store.count - 1)
    true
  end

  def validate!(num)
    
  end
end


class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = num_buckets
  end

  def insert(num)
    @store[num % @count] << num unless include?(num)
  end

  def remove(num)
    @store[num % @count].delete(num) if include?(num)
  end

  def include?(num)
    @store[num % @count].include?(num)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
  end
end

class ResizingIntSet
  attr_reader :count

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    unless include?(num)
      resize! if count == num_buckets
      @store[num % num_buckets] << num
      @count += 1
    end
  end

  def remove(num)
    if include?(num)
      @store[num % num_buckets].delete(num)
      @count -= 1
    end
  end

  def include?(num)
    @store[num % num_buckets].include?(num)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
  end

  def num_buckets
    @store.length
  end

  def resize!
    new_store = Array.new(num_buckets * 2) { Array.new }
    old_store = @store
    @store = new_store
    @count = 0
    old_store.each do |arr|
      arr.each { |item| insert(item) }
    end
  end
end
