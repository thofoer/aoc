input = File.read("input.txt").split("")

array = input.map(&:to_i)
array << array.first

p array.each_cons(2).sum{|a,b| a==b ? a : 0}