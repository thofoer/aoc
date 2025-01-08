require 'pairing_heap'
PrioQueue =  PairingHeap::MinPriorityQueue

map = File.readlines("input.txt", chomp: true)
H = map.size
W = map.map(&:size).max

Pos = Struct.new(:x, :y) do
  def +(other) = Pos.new(x+other.x, y+other.y)
  def inspect = "(#{x},#{y})"
end

Portal = Struct.new(:id, :pos, :other) do
  def outer? = [2, H-3].include?(pos.y) || [2, W-3].include?(pos.x)
  def inner? = !outer?
  def inspect = "#{id}(#{outer? ? ?o : ?i}) #{pos.inspect}"
end

start, target = nil
portals = []
portalLinks = Hash.new{|h,k| h[k] = []}
(1...H-1).each do |y|
  (1...W-1).each do |x|
    if map[y][x] =~ /[A-Z]/
      [
        [ 1,  0, -1,  0, 0, 0],
        [-1,  0,  0,  0, 1, 0],
        [ 0,  1,  0, -1, 0, 0],
        [ 0, -1,  0,  0, 0, 1]
      ].each do | dy, dx, ay, ax, by, bx, t|
        if  map[y+dy][x+dx] == ?.
          id = "#{map[y+ay][x+ax]}#{map[y+by][x+bx]}"
          portal = Portal.new(id, Pos.new(x+dx, y+dy))
          portals << portal
          portalLinks[id] << portal
          start = portal if id == "AA"
          target = portal if id == "ZZ"
        end
      end
    end
  end
end

portalLinks = portalLinks.select{|k,v| v.size == 2}.values.flat_map {|a,b| [[a,b], [b,a]]}.to_h

portalLinks.each do |k,v|
  k.other = v
  v.other = k
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
      queue.push n, dist+1
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

target.other = target

sss = Time.now

visited = {}
state = [start, 0, 0]

queue = PrioQueue.new
queue.push state, 0

until queue.empty?
  pos, level, dist = queue.pop

  (puts dist-1; break) if pos == target && level == -1
  distMap[pos]
    .each do |npos, delta|

    next if npos == start
    next if level == 0 && npos.outer? && npos != target
    next if level > 0 && npos == target

    nstate = [npos.other, level + (npos.inner? ? 1 : -1), dist + delta + 1 ]

    if  visited[nstate].nil? ||    visited[nstate] >  dist + delta + 1

      queue.push nstate, dist + delta + 1
      visited[nstate]= dist + delta + 1
    end
  end
end

puts Time.now - sss
