#! /usr/bin/ruby -w

if ARGV.first.nil?
  contents = $stdin.read
else
  contents = File.open( ARGV.shift, "rb" ) { |f| f.read }
end

words = contents.split

puts "#{words.length} words"

