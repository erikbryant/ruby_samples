#! /usr/bin/ruby -W1

require './btree.rb'

tree = BTree.new
puts "--- empty"
tree.dump
tree.insert 5
puts "--- 5"
tree.dump
tree.insert 7
puts "--- 7"
tree.dump
tree.insert 3
puts "--- 3"
tree.dump

tree2 = BTree.new
tree2.insert *[ 4, 6, 10 ]
puts "-- [ 4, 6, 10 ]"
tree2.dump

puts "Found value: " + (tree.find 7).value.to_s
puts "Value of 99 " + (tree.contains?( 99 ) ? "DOES" : "DOES NOT") + " exist"


tree.merge! tree2
puts "--- merged"
tree.dump



exit


values = [ 5, 4, 1, 3, 7, 6, 8, 2 ]
tree = BTree.new *values
tree = BTree.new 10
values.each do |v|
  tree.insert v
  tree.balance
  puts "--- tree"
  tree.dump
end
puts "--- tree"
tree.dump
puts "--- balance (1)"
tree.balance
tree.dump

exit



node = tree.find 5
puts node.in_order_successor.value
puts node.in_order_predecessor.value
puts "---- remove 5"
tree.remove 5
tree.dump
puts "---- remove 1"
tree.remove 1
tree.dump
puts "---- remove 2"
tree.remove 2
tree.dump
