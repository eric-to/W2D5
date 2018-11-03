class Node
  attr_reader :key
  attr_accessor :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end

  def remove
    @next.prev, @prev.next = @prev, @next
    @prev, @next = nil
  end
  
  def inspect
    "Key: #{@key} Val:#{ @val } "
    
  end
end


class LinkedList
  include Enumerable
  
  def initialize
    @head = Node.new
    @tail = Node.new
    
    @head.next = @tail
    @tail.prev = @head
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    @head.next
  end

  def last
    @tail.prev
  end

  def empty?
    @head.next == @tail
  end

  def get(key)
    each { |node| return node.val if node.key == key }
  end

  def include?(key)
    each { |node| return true if node.key == key }
    false
  end

  def append(key, val)

    new_node = Node.new(key, val)
    
    prev_node = @tail.prev
    
    prev_node.next = new_node
    
    new_node.prev = prev_node
    new_node.next = @tail
    
    @tail.prev = new_node
    
    new_node
  end

  def update(key, val)
    each { |node| node.val = val if node.key == key }
  end
  
  


  def remove(key)
    each do |node| 
      if node.key == key
        next_node = node.next
        prev_node = node.prev
        
        next_node.prev, prev_node.next = prev_node, next_node
      end 
    end
  end

  def each
    node = @head.next
    until node.next.nil?
      yield node
      node = node.next
    end
  end

  # uncomment when you have `each` working and `Enumerable` included
  def to_s
    inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  end
end
