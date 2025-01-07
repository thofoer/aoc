require 'pairing_heap'
PrioQueue =  PairingHeap::MinPriorityQueue

map = File.readlines("sample3.txt", chomp: true)
H = map.size
W = map.map(&:size).max

portalInner = {}
portalOuter = {}
portalMap = Hash.new{|h,k| h[k] = []}
(1...H-1).each do |y|
  (1...W-1).each do |x|
    if map[y][x] =~ /[A-Z]/
      [
        [ 1,  0, -1,  0, 0, 0],
        [-1,  0,  0,  0, 1, 0],
        [ 0,  1,  0, -1, 0, 0],
        [ 0, -1,  0,  0, 0, 1]
      ].each do | dy, dx, ay, ax, by, bx, t|
        pp = [1, H-2].include?(y) || [1, W-2].include?(x) ? portalOuter : portalInner
        pp["#{map[y+ay][x+ax]}#{map[y+by][x+bx]}"] = [y+dy,x+dx] if map[y+dy][x+dx] == ?.
        portalMap["#{map[y+ay][x+ax]}#{map[y+by][x+bx]}"] << [y+dy,x+dx] if map[y+dy][x+dx] == ?.
      end
    end
  end
end

portals = portalMap.select{|k,v| v.size == 2}.values.flat_map {|a,b| [[a,b], [b,a]]}.to_h

p portals
p portals[[2,13]]
p "---------"

start  = portalOuter["AA"]
target = portalOuter["ZZ"]

allPortals = Set.new(portalInner.keys + portalOuter.keys)

p allPortals
DIRS = [[-1,0], [0,-1], [1,0], [0,1]]
def shortestDist(map, start, target)
  queue = PrioQueue.new
  visited = Set.new

  queue.push start, 0

  until queue.empty? do
    curr, dist = queue.pop_with_priority

    return dist if curr == target

    DIRS.map{ [it[0] + curr[0], it[1] + curr[1]] }
        .select{ map[it[0]][it[1]] == ?. }
        .reject{ visited.include?(it) }
        .each do |n|
          visited << n
          queue.push n, dist+1
    end
  end
end

$nameMap = {}

def searchPaths(map, portals1, portals2)
  res = Hash.new{|h,k| h[k]={}}
  portals1.each do |p1Name, p1Pos|
    portals2.each do |p2Name, p2Pos|
      next if p1Pos == p2Pos
      dist = shortestDist(map, p1Pos, p2Pos)
      #res[[p1Name, p1Pos]][[ p2Name, p2Pos]] = dist if dist
      res[p1Pos][p2Pos] = dist if dist
    end
    $nameMap[p1Pos] = p1Name
  end
  res
end

outerToOuter = searchPaths(map, portalOuter, portalOuter)
outerToInner = searchPaths(map, portalOuter, portalInner)
innerToOuter = searchPaths(map, portalInner, portalOuter)
innerToInner = searchPaths(map, portalInner, portalInner)

 puts
 puts
# p outerToOuter
# p outerToOuter.map{|k,v| v.size}
# puts
 p outerToInner
 p outerToInner.map{|k,v| v.size}
# puts
# p innerToOuter
# p innerToOuter.map{|k,v| v.size}
# puts
# p innerToInner
# p innerToInner.map{|k,v| v.size}

State = Struct.new(:pos, :dir, :level) do
  def to_ary = [pos, dir, level]
end

state = State.new(start, :outer, 0)

queue = PrioQueue.new

queue.push state, 0
puts "start"
visited = Set.new

until queue.empty?
  (pos, dir, level), dist = queue.pop_with_priority

  puts "pos=#{pos} (#{$nameMap[pos]})  dir=#{dir} level=#{level} dist=#{dist}"
  next if visited.include? [pos, level]
  (puts dist; break) if pos == target && level == 0
  gets
  visited << [pos, level]

  if (dir == :outer)
    outerToInner[pos].each do |nextInner|
      npos, delta = nextInner
      puts "  a PUSH #{portals[npos]} (#{$nameMap[portals[npos]]}), inner, #{level+1}, #{dist+delta}"
      queue.push State.new(portals[npos], :outer, level+1), dist + delta + 1
    end
    outerToOuter[pos].each do |nextOuter|

      npos, delta = nextOuter

        next if level == 0 || (npos == target || npos==start && level>0)
      puts "  b PUSH #{npos.inspect} #{portals[npos].inspect} (#{$nameMap[portals[npos]]}), inner, #{level-1}, #{dist+delta}"
      queue.push State.new(portals[npos], :inner, level-1), dist + delta + 1
    end
  end
  if (dir == :inner)
    innerToInner[pos].each do |nextInner|
      npos, delta = nextInner
      puts "  c PUSH #{portals[npos].inspect} (#{$nameMap[portals[npos]]}), inner, #{level+1}, #{dist+delta}"
      queue.push State.new(portals[npos], :outer, level+1), dist + delta + 1
    end
    innerToOuter[pos].each do |nextOuter|
      npos, delta = nextOuter
      next if level == 0||  (npos == target || npos==start && level>0)
      puts "  d PUSH #{npos.inspect} #{portals[npos].inspect} (#{$nameMap[portals[npos]]}), inner, #{level-1}, #{dist+delta}"
      queue.push State.new(portals[npos], :inner, level-1), dist + delta + 1
    end
  end

end
