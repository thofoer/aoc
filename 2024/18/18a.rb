input = File.read("input.txt")
            .scan(/(\d+),(\d+)/m)
            .map{ |x, y| Complex(x.to_i, y.to_i)}

ADJ = [-1+0i, 0-1i, 1+0i, 0+1i]
BOUNDS = (0..70)
walls = Set.new(input[0...1024])

d = Hash.new(Float::INFINITY)
d[0+0i] = 0

queue = [0+0i]

until queue.empty?
    node = queue.pop    
    ADJ.map{ |adj| node + adj }
       .filter{ |p| BOUNDS.include?(p.real) && BOUNDS.include?(p.imag) && !walls.include?(p)}
       .each{ |p| (d[p] = d[node]+1; queue << p) if d[node]+1 < d[p] }
end

p d[70+70i]