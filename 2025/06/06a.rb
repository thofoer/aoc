input = File.readlines("input.txt").map{it.split}
values = input[..-2].map{it.map(&:to_i)}
ops = input.last.map(&:to_sym)

puts values.first.zip(*values[1..]).each_with_index.sum{ |l,i| l.reduce(ops[i])}