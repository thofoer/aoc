require 'pairing_heap'
PrioQueue =  PairingHeap::MinPriorityQueue
DIRS = [-1+0i, 0-1i, 1+0i, 0+1i]

grid = Set.new
doors, keys = {}, {}
start = nil
sss = Time.now
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

grid.delete start
grid.delete start + (1+0i)
grid.delete start + (-1+0i)
grid.delete start + (0+1i)
grid.delete start + (0-1i)

#dump(grid)


p [start + (-1-1i), start + (1-1i), start + (-1+1i), start + (+1+1i), 0, 0]

queue.push [start + (-1-1i), start + (1-1i), start + (-1+1i), start + (+1+1i), 0, 0], 0
zz=0
until queue.empty? do
    
    
    c1, c2, c3, c4, kk, dist = queue.pop
    (puts dist; break) if kk == allkeys
    
    zz+=1
    puts "#{zz}   #{queue.size}  #{dist}" if zz % 100000 == 0

    [c1, c2, c3, c4].each.with_index do |curr, i|
        DIRS.map{ it + curr }
            .select{ grid.include?(it) }            
            .each do |n|        
                state = [c1, c2, c3, c4, kk, dist+1]
                state[i] = n
                newKeys = keys[n].nil? ? kk : kk | keybit[keys[n]]                    
                newState = state.dup
                newState[4] = newKeys                
            
                if (doors[n].nil? || (kk & keybit[doors[n]]) != 0) && !visited.include?(newState)                            
                    queue.push newState, dist + 1
                    visited << newState
                end
            end        
    end    
end    

p Time.now - sss