#! /usr/bin/ruby -W1

class Ini_Parser
  require 'pp'

  def initialize
    @tree = Hash.new
    @global_section = ""
    add_section @global_section
    @current_section = @global_section
  end

  def parse_file(fh)
    # Include a 'global' section for any key-values
    # that are found outside of a named section.
    @current_section = @global_section

    fh.map { |line| parse_line line }
  end

  def parse_line(line)
    # Remove comments unless the comment char is backslash escaped
    line.sub!(/([^\\]|^)#.*/, "")
    line.sub!(/\\#/, "#")
    line.strip!

    if line.nil? or line =~ /^$/
      return
    elsif line =~ /^\[.*\]/
      @current_section = line[1...-1]
      add_section @current_section
    else
      key, value = line.split("=", 2)
      add_value @current_section, key, value
    end
  end

  def add_section(section)
    if @tree[section].nil?
      @tree[section] = Hash.new
    else
      puts "WARN: Section already exists: '#{section}'. Values may be overwritten."
    end
  end

  def has_section?(section)
    return @tree[section].nil? ? false : true
  end

  def add_value(section, key, value)
    @tree[section][key.strip] = value.nil? ? nil : value.strip
  end

  def get_value(section, key)
    return @tree[section].nil? ? nil : @tree[section][key]
  end

  def dump
    pp @tree
  end
end

