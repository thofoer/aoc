array = File.read("input.txt").split("").map(&:to_i)

p array.map.with_index.sum{|a, i| a == array[(i+array.size/2) % array.size] ? a : 0}