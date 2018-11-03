require_relative 'p04_linked_list'

class HashMap
  attr_accessor :count
  
  include Enumerable

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { LinkedList.new }
    @count = 0
  end

  def include?(key)
    bucket_num = key.hash % num_buckets
    @store[bucket_num].include?(key)
  end

  def set(key, val)
    resize! if num_buckets == count
    bucket_num = key.hash % num_buckets
    if @store[bucket_num].include?(key)
      @store[bucket_num].update(key, val)
    else
      @store[key.hash % num_buckets].append(key, val)
      @count += 1
    end
  end

  def get(key)
    @store[key.hash % num_buckets].get(key)
  end

  def delete(key)
    bucket_num = key.hash % num_buckets
    if @store[bucket_num].include?(key)
      @store[bucket_num].remove(key)
      @count -= 1
    end
  end

  def each
    @store.each { |linked_list| linked_list.each { |node| yield(node.key, node.val) } }
  end

  # uncomment when you have Enumerable included
  def to_s
    pairs = inject([]) do |strs, (k, v)|
      strs << "#{k.to_s} => #{v.to_s}"
    end
    "{\n" + pairs.join(",\n") + "\n}"
  end

  alias_method :[], :get
  alias_method :[]=, :set

  private

  def num_buckets
    @store.length
  end

  def resize!
    
    
    new_buckets = Array.new(num_buckets * 2) { LinkedList.new }
    old_buckets = @store
    @store = new_buckets
    @count = 0
    old_buckets.each do |linked_list|
      linked_list.each { |node| set(node.key, node.val)}
    end
  
  end

  def bucket(key)
    # optional but useful; return the bucket corresponding to `key`
  end
end
