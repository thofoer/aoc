*values, ops = File.readlines("input.txt")
total = i = 0

while i < ops.size
    j = ops.index(/[+*]/, i+1) || ops.size + 1
    a = values.map{ it[i...j-1].chars}
    
    total += a.first.zip(*a[1..]).map{it.join.to_i}.reduce(ops[i].to_sym)
    i = j    
end
puts total
