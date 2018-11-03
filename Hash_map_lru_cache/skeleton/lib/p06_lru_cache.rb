require_relative 'p05_hash_map'
require_relative 'p04_linked_list'
require 'byebug'

class LRUCache
  def initialize(max, prc)
    @map = HashMap.new
    @store = LinkedList.new
    @max = max
    @prc = prc
    @count = 0
  end

  def count
    @map.count
  end

  def get(key)    
    # is it in the cache?
    
    if @map.include?(key)
      hit_node = @map.get(key)
      found_square = hit_node.val
      @store.remove(hit_node.key)
      @store.append(hit_node.key, hit_node.val)
      return found_square
    end
    
    # cache miss - we need to add square to cache
    squared = @prc.call(key)
    
    if @count < @max 
      new_node = @store.append(key, squared)
      @map.set(key, new_node)
      @count += 1
    else
      # cache is full, so remove LRU square and add new square
      oldest_key = @store.first.key
      
      @store.first.remove
      @map.delete(oldest_key)
      new_node = @store.append(key, squared)
      @map.set(key, new_node)
    end
    
    # return the squared number
    squared
  end

  def to_s
    'Map: ' + @map.to_s + '\n' + 'Store: ' + @store.to_s
  end

  private

  def calc!(key)
    # suggested helper method; insert an (un-cached) key
  end

  def update_node!(node)
    # suggested helper method; move a node to the end of the list
  end

  def eject!
  end
end
