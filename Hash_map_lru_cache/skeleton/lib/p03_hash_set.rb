class HashSet
  # attr_reader :count
  # 
  # def initialize(num_buckets = 8)
  #   @store = Array.new(num_buckets) { Array.new }
  #   @count = 0
  # end
  # 
  # def insert(key)
  # end
  # 
  # def include?(key)
  # end
  # 
  # def remove(key)
  # end
  # 
  # private
  # 
  # def [](num)
  #   # optional but useful; return the bucket corresponding to `num`
  # end
  # 
  # def num_buckets
  #   @store.length
  # end
  # 
  # def resize!
  # end
  attr_reader :count

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    unless include?(num)
      resize! if count == num_buckets
      @store[num.hash % num_buckets] << num
      @count += 1
    end
  end

  def remove(num)
    if include?(num)
      @store[num.hash % num_buckets].delete(num)
      @count -= 1
    end
  end

  def include?(num)
    @store[num.hash % num_buckets].include?(num)
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
