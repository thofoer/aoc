require 'pairing_heap'
PrioQueue =  PairingHeap::MinPriorityQueue

map = File.readlines("input.txt", chomp: true)
H, W = map.size, map.map(&:size).max

Pos = Struct.new(:x, :y) do
  def +(other) = Pos.new(x+other.x, y+other.y)
  def inspect = "(#{x},#{y})"
end

Portal = Struct.new(:id, :pos, :other) do
  def outer? = pos.y == 2 || pos.y == H-3 || pos.x == 2 || pos.x == W-3
  def inspect = "#{id}(#{outer? ? ?o : ?i}) #{pos.inspect}"
end

start, target = nil
portals = []
portalLinks = Hash.new{|h,k| h[k] = []}

(1...H-1).each do |y|
  (1...W-1).each do |x|
    if map[y][x] =~ /[A-Z]/
      [
        [ 1,  0, -1,  0, 0, 0],  # vertical top
        [-1,  0,  0,  0, 1, 0],  # vertical bottom
        [ 0,  1,  0, -1, 0, 0],  # horizontal left
        [ 0, -1,  0,  0, 0, 1]   # horizontal right
      ].each do | dy, dx, ay, ax, by, bx, t|
        if  map[y+dy][x+dx] == ?.
          id = "#{map[y+ay][x+ax]}#{map[y+by][x+bx]}"
          portal = Portal.new(id, Pos.new(x+dx, y+dy))
          portals << portal
          portalLinks[id] << portal
          start  = portal if id == "AA"
          target = portal if id == "ZZ"
        end
      end
    end
  end
end

portalLinks.select{|k,v| v.size == 2}
           .values
           .each do |a,b|
               a.other = b
               b.other = a
           end

DIRS = [Pos.new(-1,0), Pos.new(0,-1), Pos.new(1,0), Pos.new(0,1)]

def shortestDist(map, p1, p2)
  queue = PrioQueue.new
  visited = Set.new

  queue.push p1.pos, 0

  until queue.empty? do
    curr, dist = queue.pop_with_priority

    return dist if curr == p2.pos

    DIRS.map{ it + curr }
        .select{ map[it.y][it.x] == ?. }
        .reject{ visited.include?(it) }
        .each do |n|
      visited << n
      queue.push n, dist + 1
    end
  end
end

distMap = Hash.new{|h,k| h[k] = {}}

portals.combination(2)
       .map { |a,b| [a, b, shortestDist(map, a, b)]}
       .reject{|_,_,d| d.nil?}
       .each do |a, b, d|
          distMap[a][b] = d
          distMap[b][a] = d
        end

def solve(distMap, start, target, maxDepth)
  visited = Set.new
  queue = PrioQueue.new
  queue.push [start, 0], 0

  until queue.empty?
    (pos, level), dist = queue.pop_with_priority

    distMap[pos].each do |npos, delta|
      return dist + delta if npos == target && level == 0
      next if level > maxDepth
      next if level == 0 && npos.outer?
      next if level  > 0 && npos == target

      nstate = [npos.other, level + (npos.outer? ? -1 : 1)]

      unless visited.include? nstate
        queue.push nstate, dist + delta + 1
        visited << nstate
      end
    end
  end
end

p solve distMap, start, target, portals.size / 2