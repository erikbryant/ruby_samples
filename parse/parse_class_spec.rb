require './parse_class.rb'

describe Ini_Parser do
  before :each do
    @parser       = Ini_Parser.new
    @test_section = "section"
    @test_key     = "key"
    @test_value   = "value"

    @parser.add_section @test_section
    @parser.add_value @test_section, @test_key, @test_value

    @new_section = "new_section"
    @new_key     = "new_key"
    @new_value   = "new_value"

    @line = "[" + @new_section + "]"
    @parser.parse_line @line

    @line = @new_key + "=" + @new_value
    @parser.parse_line @line
  end

  it 'should start with a global section' do
    p = Ini_Parser.new
    p.has_section?("").should == true
  end

  it 'should hold on to new sections' do
    @parser.has_section?(@test_section).should == true
  end

  it 'should hold on to new values' do
    @parser.get_value(@test_section, @test_key).should == @test_value
  end

  it 'should be able to parse a section definition line' do
    @parser.has_section?(@new_section).should == true
  end

  it 'should be able to parse a key-value line' do
    @parser.get_value(@new_section, @new_key).should == @new_value
  end
end
