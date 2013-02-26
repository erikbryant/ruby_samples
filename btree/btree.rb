class Node
  attr_accessor :left, :right, :value

  def initialize( value )
    @value = value
    @left  = nil
    @right = nil
  end
end

class BTree
  def initialize
    @tree = nil
  end

  def insert( value, *more_values )
    @tree = insert_helper value
    more_values.each { |v| @tree = insert_helper v }
  end

  def insert_helper( value, node=@tree )
    return Node.new( value ) if node.nil?

    if value > node.value
      node.right = insert_helper value, node.right
    else
      node.left = insert_helper value, node.left
    end

    node
  end

  def merge!( other_tree )
    return if other_tree.nil?
puts "Not Nil..."
    other_tree.in_order { |node| self.insert node.value }
  end

  def find( value, node=@tree )
    return nil if node.nil?
    return node if value == node.value
    return value < node.value ? find( value, node.left ) : find( value, node.right )
  end

  def contains?( value, node=@tree )
    not find( value, node ).nil?
  end

  def in_order_successor( node=@tree )
    return nil if node.nil? || node.right.nil?
    node = node.right
    until node.left.nil? do
      node = node.left
    end
    return node
  end

  def in_order_predecessor( node=@tree )
    return nil if node.nil? || node.left.nil?
    node = node.left
    until node.right.nil? do
      node = node.right
    end
    return node
  end

  def remove( value, node=@tree )
    if value == node.value then
      if node.left.nil? && node.right.nil? then
        # You can't delete the root node if there are no children :-(
      elsif node.left.nil? then
        node.value = node.right.value
        node.left  = node.right.left
        node.right = node.right.right
      elsif node.right.nil? then
        node.value = node.left.value
        node.left  = node.left.left
        node.right = node.left.right
      else
        successor = node.in_order_successor
        node.value = successor.value
        node.right.remove successor.value
      end
    else
      if value < node.value then
        return if node.left.nil?
        if value == node.left.value && node.left.left.nil? && node.left.right.nil? then
          node.left = nil
        else
          node.left.remove value
        end
      else
        return if node.right.nil?
        if value == node.right.value && node.right.left.nil? && node.right.right.nil? then
          node.right = nil
        else
          node.right.remove value
        end
      end
    end 
  end

  def depth( node=@tree )
    node.nil? ? 0 : [ depth( node.left ), depth( node.right ) ].max + 1
  end

  def count( node=@tree )
    node.nil? ? 0 : 1 + count( node.left ) + count( node.right )
  end

  def balanced?( node=@tree )
    return true if node.nil?
    a = count node.left
    b = count node.right
    if (a - b).abs > 1
      return false
    end
    return balanced?( node.left ) && balanced?( node.right )
  end

  #
  #     a                b
  #    / \              / \
  #   1   b     =>     a   c
  #      / \          /\   /\
  #     2   c        1  2 3  4
  #        / \
  #       3  4
  #
  def left_rotate( node=@tree )
    node.left = node.right
    node.right = node.right.right
    node.left.right = nil
    node.value, node.left.value = node.left.value, node.value
  end

  #
  #     a                b
  #    / \              / \
  #   1   c     =>     a   c
  #      / \          /\   /\
  #     b   4        1  2 3  4
  #    / \
  #   2   3
  #
  def double_left_rotate( node=@tree )
    node.left = node.right.left
    node.right.left = nil
    node.value, node.left.value = node.left.value, node.value
  end

  #
  #         c                b
  #        / \              / \
  #       b   4     =>     a   c
  #      / \              /\   /\
  #     a   3            1  2 3  4
  #    / \
  #   1   2
  #
  def right_rotate( node=@tree )
    node.right = node.left
    node.left = node.left.left
    node.right.left = nil
    node.value, node.right.value = node.right.value, node.value
  end

  #
  #       c                b
  #      / \              / \
  #     a   4     =>     a   c
  #    / \              /\   /\
  #   1   b            1  2 3  4
  #      / \
  #     2   3
  #
  def double_right_rotate( node=@tree )
    node.right = node.left.right
    node.left.right = nil
    node.value, node.right.value = node.right.value, node.value
  end

  def balance( node=@tree )
    return if node.nil?
    depth_left  = depth( node.left )
    depth_right = depth( node.right )
    if ( depth_left - depth_right ).abs > 1 then
      if depth_right > depth_left then
        if depth( node.right.left ) > depth( node.right.right )
          node.double_left_rotate
        else
          node.left_rotate
        end
      else
        if depth( node.left.left ) < depth( node.left.right )
          node.double_right_rotate
        else
          node.right_rotate
        end
      end
    end
  end

  def pre_order( node=@tree, &block )
    return if node.nil?
    block.call( node )
    pre_order node.left, &block
    pre_order node.right, &block
  end

  def in_order( node=@tree, &block )
    return if node.nil?
    in_order node.left, &block
    block.call( node )
    in_order node.right, &block
  end

  def post_order( node=@tree, &block )
    return if node.nil?
    post_order node.left, &block
    post_order node.right, &block
    block.call( node )
  end

  def breadth_first( node=@tree, &block )
    return if node.nil?
    queue = [ node ]
    until queue.empty? do
      node = queue.shift
      block.call( node )
      queue << node.left unless node.left.nil?
      queue << node.right unless node.right.nil?
    end
  end

  def dump( node=@tree, depth=0, marker="" )
    return if node.nil?
    dump node.right, depth+1, "/"
    puts "    " * depth + marker + node.value.to_s
    dump node.left, depth+1, "\\"
  end
end
