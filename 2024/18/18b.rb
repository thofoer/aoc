input = File.read("input.txt")
            .scan(/(\d+),(\d+)/m)
            .map{ |x, y| Complex(x.to_i, y.to_i)}

ADJ = [-1+0i, 0-1i, 1+0i, 0+1i]
BOUNDS = (0..70)
walls = Set.new(input)

def reachable?(walls)
    visited = Set.new([0+0i])
    queue = [0+0i]    
    until queue.empty?
        node = queue.pop
        return true if node == 70+70i
        ADJ.map{ |adj| node + adj }
           .filter{ |p| BOUNDS.include?(p.real) && BOUNDS.include?(p.imag) && !walls.include?(p) && !visited.include?(p)}
           .each{ |p| visited << p; queue << p }
    end
end

pos = input[input.rindex{ |v| reachable?(walls.delete(v))}]

puts "#{pos.real},#{pos.imag}"
