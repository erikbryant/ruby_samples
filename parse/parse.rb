#! /usr/bin/ruby -W1

require './parse_class.rb'

parser = Ini_Parser.new
parser.parse_file ARGV.first ? File.open(ARGV.shift) : $stdin

parser.dump

