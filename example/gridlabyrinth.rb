require 'pairing_heap'
PrioQueue =  PairingHeap::MinPriorityQueue
DIRS = [-1+0i, 0-1i, 1+0i, 0+1i]

def read(filename)
    grid = Set.new
    poi = {}
    File.readlines(filename, chomp: true).each_with_index do |l, y|
        l.chars.each.with_index do |c, x| 
            p =  Complex(x,y)
            grid << p unless c == ?#
            poi[c] = p if c!=?# && c!=?.
        end
    end
    [grid, poi]
end

def dump(map, path=[])
    xMin, xMax = map.map(&:real).minmax
    yMin, yMax = map.map(&:imag).minmax

    (yMin-1..yMax+1).each do |y|
        (xMin-1..xMax+1).each do |x|
            p = Complex(x,y)
            if path.include? p
                print ?o
            else
                print map.include?(p) ? ?. : ?#
            end
        end
        puts
    end
end

def removeDeadEnds(map, poi=[])
    ready = false
    until ready do 
        ready = true
        newMap = Set.new
        map.each do |pos|
            if DIRS.map{it + pos}.to_set.intersection(map).size == 1
                ready = false
            else
                newMap << pos 
            end
        end
        map = newMap
    end
    map
end

def shortestDist(map, start, target)
    queue = PrioQueue.new
    visited = Set.new
    
    queue.push start, 0

    until queue.empty? do
        curr, dist = queue.pop_with_priority
        return dist if curr == target      
        
        visited << curr

        DIRS.map{ it + curr }
            .select{ map.include?(it) }
            .reject{ visited.include?(it) }
            .each do |n|
                queue.push n, dist+1
            end        
    end    
end

def shortestPath(map, start, target)
    queue = PairingHeap::MinPriorityQueue.new
    visited = Set.new
    
    queue.push [start], 0

    until queue.empty? do
        path, dist = queue.pop_with_priority
        return path if path.last == target      
        
        visited << path.last
        DIRS.map{ it + path.last }
            .select{map.include?(it)}
            .reject{visited.include?(it)}
            .each do |n|
                queue.push (path.dup << n), dist+1
            end        
    end    
end

l1 = read("labyrinth.txt")

grid, poi = l1
dump(grid)
puts
g2 = removeDeadEnds(grid)
dump(g2)
#p shortestDist(grid, poi[?@], poi[?$])
#sp = shortestPath(grid, poi[?@], poi[?$])

#dump(grid, sp)


