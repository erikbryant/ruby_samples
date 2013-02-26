#!/usr/bin/ruby -w

# A sorted (but not balenced) binary tree class

require 'pp'


class BinaryTree

  def initialize
    @tree = nil
  end

  def _new_node(value=nil, left=nil, right=left)
    { :value => value, :count => 1, :left => nil, :right => nil }
  end

  def add(value, node=@tree)
    if node.nil?
      @tree = _new_node(value)
    elsif value == node[:value]
      node[:count] += 1
    elsif value < node[:value]
      if node[:left].nil?
        node[:left] = _new_node(value)
      else
        self.add(value, node[:left])
      end
    else
      if node[:right].nil?
        node[:right] = _new_node(value)
      else
        self.add(value, node[:right])
      end
    end
    @tree
  end

  def find(value, node=@tree)
    return nil if node.nil?
    if node[:value] == value
      node
    elsif value < node[:value]
      self.find(value, node[:left])
    else
      self.find(value, node[:right])
    end
  end

  # calculate depth of deepest node
  def height(node=@tree)
    node.nil? ? 0 : 1 + [self.height(node[:left]), self.height(node[:right])].max
  end

  # return a count of nodes in the tree
  def size(node=@tree)
    node.nil? ? 0 : node[:count] + self.size(node[:left]) + self.size(node[:right])
  end

  # depth-first traversal
  def each(node=@tree)
    return if node.nil?
    self.each(node[:left]) {|v| yield v}
    (1..node[:count]).each {|i| yield node}
    self.each(node[:right]) {|v| yield v}
  end

  # breadth-first traversal, left to right
  def each_bf(node=@tree)
    return if node.nil?
    (1..node[:count]).each {|i| yield node}
    self.each(node[:left]) {|v| yield v}
    self.each(node[:right]) {|v| yield v}
  end

  def print(node=@tree)
    self.each(node) do |n|
      puts n[:value]
    end
  end

  def root
    @tree
  end

  # max height and min height must differ by no more than 1
  def balanced?(node=@tree)
    node.nil? or ((height(node[:left]) - height(node[:right])).abs <= 1)
  end

end



tree = BinaryTree.new

f = ARGV.shift
File.open(f).each { |line| tree.add(line.to_i) }

puts "height: #{tree.height}"
puts "nodes: #{tree.size}"
puts "balanced: #{tree.balanced?}"

puts
tree.print

puts
tree.each_bf do |node|
  puts node[:value]
end

