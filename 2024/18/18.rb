input = File.read("input.txt")
            .scan(/(\d+),(\d+)/m)
            .map{ |x, y| Complex(x.to_i, y.to_i)}

ADJ = [-1+0i, 0-1i, 1+0i, 0+1i]
START, TARGET = 0+0i, 70+70i
BOUNDS = (0..70)

def dist(walls, pos)
    queue = [START]
    d = Hash.new(Float::INFINITY)
    d[START] = 0
    until queue.empty?
        node = queue.pop    
        ADJ.map{ |adj| node + adj }
           .filter{ |p| BOUNDS.include?(p.real) && BOUNDS.include?(p.imag) && !walls.include?(p)}
           .each{ |p| (d[p] = d[node]+1; queue << p) if d[node]+1 < d[p] }
    end
    d[TARGET]
end

def reachable?(walls)
    visited = Set.new([START])
    queue = [START]    
    until queue.empty?
        node = queue.pop
        return true if node == TARGET
        ADJ.map{ |adj| node + adj }
           .filter{ |p| BOUNDS.include?(p.real) && BOUNDS.include?(p.imag) && !walls.include?(p) && !visited.include?(p)}
           .each{ |p| visited << p; queue << p }
    end
end

puts dist(Set.new(input[0...1024]), START)

walls = Set.new(input)
pos = input[input.rindex{ |v| reachable?(walls.delete(v))}]

puts "#{pos.real},#{pos.imag}"
