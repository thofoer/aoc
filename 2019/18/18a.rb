require 'pairing_heap'
PrioQueue =  PairingHeap::MinPriorityQueue
DIRS = [-1+0i, 0-1i, 1+0i, 0+1i]

grid = Set.new
doors, keys = {}, {}
start = nil
sss = Time.now

File.readlines("input.txt", chomp: true).each_with_index do |l, y|
    l.chars.each.with_index do |c, x| 
        p =  Complex(x,y)
        grid << p unless c == ?#
        start = p if c == ?@
        doors[p] = c.downcase if c =~ /[A-Z]/
        keys[p]  = c if c =~ /[a-z]/
    end
end

def removeDeadEnds(map, poi=[])
    ready = false
    until ready do 
        ready = true
        newMap = Set.new
        map.each do |pos|
            if (DIRS.map{it + pos}.to_set.intersection(map).size == 1 ) && !poi.include?(pos)            
                ready = false
            else
                newMap << pos 
            end
        end
        map = newMap
    end
    map
end

grid = removeDeadEnds(grid, keys.keys + doors.keys)
queue = PrioQueue.new
visited = Set.new
keybit = Hash.new{ |h,k| h[k] = 1 << (k.bytes.first - 97) }

allkeys = (1 << keys.size) - 1

queue.push [start, 0], 0

until queue.empty? do
    (curr, kk), dist = queue.pop_with_priority    
    (puts dist; break) if kk == allkeys
    
    DIRS.map{ it + curr }
        .select{ grid.include?(it) }
        .reject{ visited.include?([it, kk])}
        .each do |n|        
            if doors[n].nil? || (kk & keybit[doors[n]]) != 0
                newState = [n, keys[n].nil? ? kk : kk | keybit[keys[n]]]                
                visited << newState
                queue.push newState, dist+1 
            end
        end        
end    

p Time.now - sss