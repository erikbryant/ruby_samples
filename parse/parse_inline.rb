#! /usr/bin/ruby -W1

require 'pp'

global_section = "[__GLOBAL__]"

fh = ARGV.first ? File.open(ARGV.shift) : $stdin

contents = fh.map {|line| line}

# Remove comments and any leading/trailing whitespace
# Preserve comment chars in strings if they are backslash escaped
contents.map! { |line| line.sub(/([^\\]|^)#.*/, "") }
contents.map! { |line| line.sub(/\\#/, "#") }
contents.map! { |line| line.strip }

tree = Hash.new
section = global_section
tree[section] = Hash.new

contents.each do |line|
  if line.nil? or line =~ /^$/
    section = global_section
  elsif line =~ /^\[.*\]/
    section = line
    if tree[section].nil?
      tree[section] = Hash.new
    else
      puts "WARN: Duplicate section found: '#{section}'. Values may be overwritten."
    end
  else
    key, value = line.split("=", 2)
    tree[section][key.strip] = value.nil? ? nil : value.strip
  end
end

pp tree
