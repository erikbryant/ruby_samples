#! /usr/bin/ruby -W1

fh = ARGV.first ? File.open(ARGV.shift) : $stdin

contents = fh.map {|line| line.split}

contents.reverse.each { |line| puts line.reverse.join(" ") }

