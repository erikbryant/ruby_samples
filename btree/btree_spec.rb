require './btree.rb'

describe BTree do
  before :each do
    @tree1 = BTree.new
    @tree2 = BTree.new
  end

  it 'should initialize to empty' do
    @tree1.depth.should == 0
    @tree1.count.should == 0
    @tree1.balanced?.should == true
  end

  it 'should allow a value to be inserted' do
    @tree1.insert 10
    @tree1.depth.should == 1
    @tree1.count.should == 1
    @tree1.balanced?.should == true
  end

  it 'should insert in sorted order' do
    values = [ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 ]
    values.reverse.each { |v| @tree1.insert v }
    a = []
    @tree1.in_order { |node| a << node.value }
    a.should == values
  end

  it 'should contain values that were inserted' do
    values = [ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 ]
    not_values = [ 92, 400, 34 ]
    values.each { |v| @tree1.insert v }
    values.each { |v| @tree1.contains?( v ).should == true }
    not_values.each { |v| @tree1.contains?( v ).should == false }
  end

  it 'should allow a value to be delted' do
  end

  it 'should calculate the depth' do
    @tree1.depth.should == 0
    @tree1.insert 10
    @tree1.depth.should == 1
    @tree1.insert 5
    @tree1.depth.should == 2
    @tree1.insert 3
    @tree1.depth.should == 3
    @tree1.insert 15
    @tree1.depth.should == 3
    @tree1.insert 19
    @tree1.depth.should == 3
    @tree1.insert 20
    @tree1.depth.should == 4
    @tree1.insert 13
    @tree1.depth.should == 4
    @tree1.insert 7
    @tree1.depth.should == 4
  end

  it 'should count the nodes' do
    count = 0
    values = [ 10, 5, 3, 15, 19, 20, 13, 7 ]
    values.each do |v|
      @tree1.insert v
      count += 1
      @tree1.count.should == count
    end
  end

  it 'should determine whether the tree is balanced (1)' do
    @tree1.balanced?.should == true
    @tree1.insert 10
    @tree1.balanced?.should == true
    @tree1.insert 5
    @tree1.balanced?.should == true
    @tree1.insert 3
    @tree1.balanced?.should == false
    @tree1.insert 15
    @tree1.balanced?.should == true
    @tree1.insert 19
    @tree1.balanced?.should == true
    @tree1.insert 20
    @tree1.balanced?.should == false
    @tree1.insert 13
    @tree1.balanced?.should == false
    @tree1.insert 7
    @tree1.balanced?.should == true
  end

  it 'should determine whether the tree is balanced (2)' do
    @tree1.balanced?.should == true
    @tree1.insert 10
    @tree1.balanced?.should == true
    @tree1.insert 9
    @tree1.balanced?.should == true
    @tree1.insert 11
    @tree1.balanced?.should == true
    @tree1.insert 8
    @tree1.balanced?.should == true
    @tree1.insert 12
    @tree1.balanced?.should == true
    @tree1.insert 7
    @tree1.balanced?.should == false
    @tree1.insert 13
    @tree1.balanced?.should == false
  end

  def test_pre_order
    values = [ 5, 2, 6, 1, 3, 7, 4 ]
    values.each { |v| @tree1.insert v }
    a = []
    @tree1.pre_order { |node| a << node.value }
    a.should == [ 5, 2, 1, 3, 4, 6, 7 ]
  end

  def test_in_order
    values = [ 5, 2, 6, 1, 3, 7, 4 ]
    values.each { |v| @tree1.insert v }
    a = []
    @tree1.in_order { |node| a << node.value }
    a.should == values.sort
  end

  def test_post_order
    values = [ 5, 2, 6, 1, 3, 7, 4 ]
    values.each { |v| @tree1.insert v }
    a = []
    @tree1.post_order { |node| a << node.value }
    a.should == [ 1, 4, 3, 2, 7, 6, 5 ]
  end

  def test_breadth_first
    values = [ 5, 2, 6, 1, 3, 7, 4 ]
    values.each { |v| @tree1.insert v }
    a = []
    @tree1.breadth_first { |node| a << node.value }
    a.should == [ 5, 2, 6, 1, 3, 7, 4 ]
  end
end
