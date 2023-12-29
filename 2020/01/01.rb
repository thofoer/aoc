input = File.read("input.txt").split("\n").map(&:to_i)

puts input.combination(2).select{ |a, b| a + b == 2020}.map{|a,b| a*b }.first
puts input.combination(3).select{ |a, b, c| a + b + c == 2020}.map{|a, b, c| a * b * c }.first