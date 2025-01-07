require 'pairing_heap'
PrioQueue =  PairingHeap::MinPriorityQueue

map = File.readlines("input.txt", chomp: true)
H = map.size
W = map.map(&:size).max

portalMap = Hash.new{|h,k| h[k] = []}

(1...H-1).each do |y|
  (1...W-1).each do |x|
    if map[y][x] =~ /[A-Z]/
      [
        [ 1,  0, -1,  0, 0, 0],
        [-1,  0,  0,  0, 1, 0],
        [ 0,  1,  0, -1, 0, 0],
        [ 0, -1,  0,  0, 0, 1]
      ].each do | dy, dx, ay, ax, by, bx|
        portalMap["#{map[y+ay][x+ax]}#{map[y+by][x+bx]}"] << [y+dy,x+dx] if map[y+dy][x+dx] == ?.
      end
    end
  end
end

start  = portalMap["AA"].first
target = portalMap["ZZ"].first

portals = portalMap.select{|k,v| v.size == 2}.values.flat_map {|a,b| [[a,b], [b,a]]}.to_h

DIRS = [[-1,0], [0,-1], [1,0], [0,1]]

queue = PrioQueue.new
visited = Set.new

queue.push start, 0

until queue.empty? do
  curr, dist = queue.pop_with_priority

  (puts dist; break) if curr == target

  neighbours = DIRS.map{ [it[0] + curr[0], it[1] + curr[1]] }
                   .select{ map[it[0]][it[1]] == ?. }
  jump = portals[curr]
  neighbours << jump if jump

  neighbours
      .reject{ visited.include?(it) }
      .each do |n|
    visited << n
    queue.push n, dist+1
  end
end