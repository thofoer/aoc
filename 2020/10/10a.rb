diffs = File.read("input.txt").split("\n").map(&:to_i).push(0).sort.each_cons(2).map{|a,b| b-a}
puts "Part 1: #{diffs.count(1) * ( 1 + diffs.count(3))}"