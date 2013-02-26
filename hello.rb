#!/usr/bin/ruby

PI = 3.14159

class Circle
  def radius
    @value
  end

  def initialize(radius)
    @radius = radius
  end

  def area
    return ( @radius * @radius * PI )
  end
end

def area( radius )
  return ( radius * radius * PI )
end

puts "Hello, world!"

i = 0

while i < ARGV.length do
  puts "ARGV[#{i}] = " + ARGV[i]
  i += 1
end

r = 10.2
a = area( r )
puts "The area of a circle with radius: #{r} is: #{a}"

c = Circle.new(r)
a = c.area()
puts "The area of a circle with radius: #{r} is: #{a}"

