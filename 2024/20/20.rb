grid = File.read("input.txt").split("\n")

W, H   = grid.size, grid[0].size
DIRS   = [1+0i, 0-1i, -1+0i, 0+1i].freeze
map    = Set.new
start, target  = nil, nil

W.times do |y|
  H.times do |x|
    p = Complex(x,y)
    value = grid[y][x]
    map << p unless value == ?#
    start  = p if value == ?S
    target = p if value == ?E
  end
end

@dist = Hash.new(Float::INFINITY)

@dist[target] = 0
queue = [target]
visited = Set.new

until queue.empty?
    node = queue.pop
    visited << node
    DIRS.map{ node + _1 }
        .filter{ map.include?(_1) && !visited.include?(_1)}
        .each do |pos|            
            @dist[pos] = @dist[node] + 1
            queue << pos
    end    
end

def manhattan(a, b) = (a.real-b.real).abs + (a.imag-b.imag).abs

def count(cheatsize) =
    @dist.keys.combination(2)
         .filter{|a,b| manhattan(a,b) <= cheatsize}
         .count{ |a,b| @dist[b] - @dist[a] >= manhattan(a,b) + 100}
         #.count(true)
         
puts count(2), count(20)