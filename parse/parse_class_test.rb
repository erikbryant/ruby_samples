#! /usr/bin/ruby -W1

require 'test/unit'
require './parse_class.rb'

class Ini_Parser_Test < Test::Unit::TestCase
  def test_new_object
    parser       = Ini_Parser.new

    assert parser.has_section? ""
  end

  def test_add_section
    parser       = Ini_Parser.new
    test_section = "section"

    parser.add_section test_section
    assert parser.has_section? test_section
  end

  def test_add_value
    parser       = Ini_Parser.new
    test_section = "section"
    test_key     = "key"
    test_value   = "value"

    parser.add_section test_section
    parser.add_value test_section, test_key, test_value
    result = parser.get_value test_section, test_key
    assert_equal result, test_value
  end

  def test_parse_section_line
    parser       = Ini_Parser.new
    test_section = "section"
    test_key     = "key"
    test_value   = "value"

    line = "[" + test_section + "]"
    parser.parse_line line
    assert parser.has_section? test_section
  end

  def test_parse_keyvalue_line
    parser       = Ini_Parser.new
    test_section = "section"
    test_key     = "key"
    test_value   = "value"

    line = "[" + test_section + "]"
    parser.parse_line line
    line = test_key + "=" + test_value

    parser.parse_line line
    assert parser.has_section? test_section
    result = parser.get_value test_section, test_key
    assert_equal result, test_value
  end
end
