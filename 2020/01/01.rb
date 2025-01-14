input = File.readlines("input.txt").map(&:to_i)

p input.combination(2).find{ it.sum == 2020}.reduce(&:*)
p input.combination(3).find{ it.sum == 2020}.reduce(&:*)
