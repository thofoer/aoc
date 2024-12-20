start, target, map = nil, nil, Set.new

File.readlines("input.txt").each_with_index do |l, y|
    l.chars.each.with_index do |c, x| 
      p = Complex(x,y)     
      map << p unless c == ?#
      start  = p if c == ?S
      target = p if c == ?E
    end
end

DIRS  = [1+0i, 0-1i, -1+0i, 0+1i].freeze
@dist = {}

@dist[target] = 0
queue = [target]
visited = Set.new

until queue.empty?
    node = queue.pop
    visited << node
    DIRS.map{ node + _1 }
        .filter{ map.include?(_1) && !visited.include?(_1)}
        .each{ |pos| @dist[pos] = @dist[node] + 1; queue << pos }    
end

def manhattan(a, b) = (a.real-b.real).abs + (a.imag-b.imag).abs

def count(cheatsize) =
    @dist.keys.combination(2)
         .filter{ |a,b| manhattan(a,b) <= cheatsize }
         .count{ |a,b| @dist[b] - @dist[a] >= manhattan(a,b) + 100 }         
         
puts count(2), count(20)