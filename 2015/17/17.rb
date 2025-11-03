c = File.readlines("input.txt").map(&:to_i)

combs = (1..c.size).map{|i| c.combination(i).to_a}.flatten(1)

p combs.count { it.sum == 150 }
p combs.filter{ it.sum == 150 }.map{it.size}.tally.find.min.last