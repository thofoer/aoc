input = File.read("input.txt").split("\n").map{ _1.split(" ").map(&:to_f)}

p input.map(&:minmax).map{_1 - _2}.sum(&:abs).to_i

p input.map{_1.combination(2).map(&:sort).map{|a,b| b / a}}.flatten.select{ _1 % 1 == 0}.sum.to_i