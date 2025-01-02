require 'pairing_heap'
PrioQueue =  PairingHeap::MinPriorityQueue
DIRS = [-1+0i, 0-1i, 1+0i, 0+1i]


grid = Set.new
doors, keys = {}, {}
start = nil
File.readlines("input.txt", chomp: true).each_with_index do |l, y|
    l.chars.each.with_index do |c, x| 
        p =  Complex(x,y)
        grid << p unless c == ?#
        start = p if c == ?@
        doors[p] = c if c =~ /[A-Z]/
        keys[p]  = c if c =~ /[a-z]/
    end
end

queue = PrioQueue.new
visited = Set.new

queue.push [start, Set.new], 0

until queue.empty? do
    (curr, kk), dist = queue.pop_with_priority    
    (puts dist; break) if kk.size == keys.size
    
    DIRS.map{ it + curr }
        .select{ grid.include?(it) }        
        .each do |n|        
            if (doors[n].nil? || kk.include?(doors[n].downcase)) && !visited.include?([n, kk])                
                newKeys = kk.dup
                newKeys << keys[n] unless keys[n].nil?
                visited << [n, newKeys]
                queue.push [n, newKeys], dist+1 
            end
        end        
end    