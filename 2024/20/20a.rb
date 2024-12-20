grid = File.read("input.txt").split("\n")

W, H   = grid.size, grid[0].size
map    = Set.new
start  = nil
target = nil
DIRS   = [1+0i, 0-1i, -1+0i, 0+1i].freeze

W.times do |y|
  H.times do |x|
    p = Complex(x,y)
    value = grid[y][x]
    map << p unless value == ?#
    start  = p if value == ?S
    target = p if value == ?E
  end
end

dist = Hash.new(Float::INFINITY)

dist[target] = 0
queue = [target]
visited = Set.new

until queue.empty?
    node = queue.pop
    visited << node
    DIRS.map{ node + _1 }
        .filter{ map.include?(_1) && !visited.include?(_1)}
        .each do |pos|            
            dist[pos] = dist[node] + 1
            queue << pos
    end    
end

zz=0

dist.entries.each do |pos, d|
    #puts "#{pos}  #{d}"
    shortcuts = DIRS.map{ pos + 2*_1}
                    .filter{ map.include?(_1) && dist[_1]+2 < dist[pos] }
                    #.each {zz+=1; puts " -->  #{dist[pos]} #{_1}  #{dist[_1]} #{dist[pos] - dist[_1] - 2}"}
                    .each {zz+=1 if dist[pos] - dist[_1] - 2 >= 100}

end

puts zz