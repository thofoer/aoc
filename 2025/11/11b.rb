GRAPH = File.readlines("input.txt").map{ it.scan(/(...): (.*)/)}
           .flatten(1)
           .map{|node, neighbours| [node, neighbours.split]}
           .to_h


def pred(n)
    GRAPH.select{|k,v| v.include?(n)}.map(&:first)
end

def children(node)
    queue = [node]
    visited = Set.new

    until queue.empty?
        n = queue.pop
        visited << n
        neighbours = GRAPH[n]
        unless neighbours.nil?
            GRAPH[n].each {
                queue << it unless visited.include?(it)
            }
        end
    end
    visited
end

def solve(start, target)
    children = children(start)

    pathcount = Hash.new{|h,k| h[k] = 0 unless children.include?(k)}
    pathcount[start] = 1
    visited = Set.new
    queue = GRAPH[start].dup    
    until queue.empty?
        n = queue.shift
        next if visited.include?(n)
        #puts "n: #{n}"
        p = pred(n).map{pathcount[it]}
        if p.any?(nil)          
            queue << n unless n == target 
            next
        end
        pathcount[n] = p.sum
        visited << n
        GRAPH[n].each {queue << it } unless GRAPH[n].nil?
        #puts "queue: #{queue}"
        #puts "path: #{pathcount}"
        #gets
    end
    pathcount[target]
end

#count(["svr"], "dac")

#p PATHCOUNT["dac"]

p solve("dac", "out")

# svr -> dac: 300856682806
# svr -> fft: 16279    
# dac -> fft: 0
# fft -> dac: 3408588
# fft -> out: 2345470204960
# dac -> out: 9055

# 409447 * 1854003136 * 9055 = 6873795579443546560