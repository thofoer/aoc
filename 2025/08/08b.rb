def dist(x,y) = x.zip(y).map{it.reduce(&:-)}.sum{it**2}
circuit = Set.new

File.readlines("08/input.txt")
            .map{ it.split(?,).map(&:to_i)}
            .combination(2)
            .sort_by{ dist *it }
            .each do |a,b|
    circuit << a << b
    (puts a[0] * b[0]; break) if circuit.size == 1000
end