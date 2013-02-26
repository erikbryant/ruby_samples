#! /usr/bin/ruby -W1

require 'test/unit'
require './btree.rb'

class BTree_Test < Test::Unit::TestCase
  def test_initialize
    tree = BTree.new
    assert tree.depth == 0
    assert tree.count == 0
    assert tree.balanced? == true
  end

  def test_insert
    tree = BTree.new
    tree.insert 10
    assert tree.depth == 1
    assert tree.count == 1
    assert tree.balanced? == true
  end

  def test_insert_is_ordered
    tree = BTree.new
    values = [ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 ]
    values.reverse.each { |v| tree.insert v }
    a = []
    tree.in_order { |node| a << node.value }
    assert a == values
  end

  def test_contains
    tree = BTree.new
    values = [ 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 ]
    not_values = [ 92, 400, 34 ]
    values.each { |v| tree.insert v }
    values.each { |v| assert tree.contains? v }
    not_values.each { |v| assert tree.contains?( v ) == false }
  end

  def test_remove
  end

  def test_depth
    tree = BTree.new
    assert tree.depth == 0
    tree.insert 10
    assert tree.depth == 1
    tree.insert 5
    assert tree.depth == 2
    tree.insert 3
    assert tree.depth == 3
    tree.insert 15
    assert tree.depth == 3
    tree.insert 19
    assert tree.depth == 3
    tree.insert 20
    assert tree.depth == 4
    tree.insert 13
    assert tree.depth == 4
    tree.insert 7
    assert tree.depth == 4
  end

  def test_count
    tree = BTree.new
    count = 0
    values = [ 0, 10, 5, 3, 15, 19, 20, 13, 7 ]
    values.each do |v|
      tree.insert v
      count += 1
      assert tree.count == count
    end
  end

  def test_balanced_1
    tree = BTree.new
    assert tree.balanced? == true
    tree.insert 10
    assert tree.balanced? == true
    tree.insert 5
    assert tree.balanced? == true
    tree.insert 3
    assert tree.balanced? == false
    tree.insert 15
    assert tree.balanced? == true
    tree.insert 19
    assert tree.balanced? == true
    tree.insert 20
    assert tree.balanced? == false
    tree.insert 13
    assert tree.balanced? == false
    tree.insert 7
    assert tree.balanced? == true
  end

  def test_balanced_2
    tree = BTree.new
    assert tree.balanced? == true
    tree.insert 10
    assert tree.balanced? == true
    tree.insert 9
    assert tree.balanced? == true
    tree.insert 11
    assert tree.balanced? == true
    tree.insert 8
    assert tree.balanced? == true
    tree.insert 12
    assert tree.balanced? == true
    tree.insert 7
    assert tree.balanced? == false
    tree.insert 13
    assert tree.balanced? == false
  end

  def test_pre_order
    tree = BTree.new
    values = [ 5, 2, 6, 1, 3, 7, 4 ]
    values.each { |v| tree.insert v }
    a = []
    tree.pre_order { |node| a << node.value }
    assert a == [ 5, 2, 1, 3, 4, 6, 7 ]
  end

  def test_in_order
    tree = BTree.new
    values = [ 5, 2, 6, 1, 3, 7, 4 ]
    values.each { |v| tree.insert v }
    a = []
    tree.in_order { |node| a << node.value }
    assert a == values.sort
  end

  def test_post_order
    tree = BTree.new
    values = [ 5, 2, 6, 1, 3, 7, 4 ]
    values.each { |v| tree.insert v }
    a = []
    tree.post_order { |node| a << node.value }
    assert a == [ 1, 4, 3, 2, 7, 6, 5 ]
  end

  def test_breadth_first
    tree = BTree.new
    values = [ 5, 2, 6, 1, 3, 7, 4 ]
    values.each { |v| tree.insert v }
    a = []
    tree.breadth_first { |node| a << node.value }
    assert a == [ 5, 2, 6, 1, 3, 7, 4 ]
  end
end
