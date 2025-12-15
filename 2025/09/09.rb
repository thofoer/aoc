nodes = File.readlines("input.txt").map{it.split(?,).map(&:to_i)}
nodes << nodes.first

def size(rect)
  (x1,y1), (x2,y2) = rect
  ((x1-x2).abs + 1) * ((y1-y2).abs + 1)
end

def sortedRects(nodes)
    nodes.combination(2).map{[*it]}.sort_by{-size(it)}
end

def dump(grid)
    file = File.new("out.txt", "w")
    0.upto(500) do |y|
        0.upto(500) do |x|        
            file.print grid.include?([x,y]) ? ?# : ?.            
        end
        file.puts
    end
    file.close
end

# Yields all coordinates of a rectangle (transposed)
def rect(a, b)
    (x1, y1), (x2, y2) = a, b
    x1, x2 = [x1, x2].minmax.map{transx(it)}
    y1, y2 = [y1, y2].minmax.map{transy(it)}
    Enumerator.new do |yielder|
        x1.upto(x2).each { yielder << [it, y1] << [it, y2] }        
        (y1+1).upto(y2-1).each { yielder << [x1, it] << [x2, it] }         
    end
end

rects = sortedRects(nodes)
puts "Part 1: #{size(rects.first)}"

def makeGrid(nodes)
    grid = Set.new
    nodes.each_cons(2).each do |a,b|     
        rect(a,b).each{ grid << it }
    end    
    grid
end

# Make functions to transpose x and y coordinates 
# from large coordinate system to compressed one
def makeTransposeFunctions(nodes)
    xs, ys = nodes.transpose.map(&:uniq!).map(&:sort)

    mapx = xs.zip(1.step(by: 2)).to_h
    mapy = ys.zip(1.step(by: 2)).to_h
    [lambda{mapx[it]}, lambda{mapy[it]}]
end

def floodfill(grid, start)
    px = transx(start[0])
    py = transy(start[1])
    queue = []
    queue << [px+1, py+1]
    
    until queue.empty?
        n = queue.pop

        [[n[0],   n[1]+1],
         [n[0]+1, n[1]  ],
         [n[0]-1, n[1]  ],
         [n[0],   n[1]-1]]
         .each do
            next if grid.include?(it)    
            grid << it
            queue << it
         end
    end
end

$transxfunc, $transyfunc = makeTransposeFunctions(nodes)

def transx(x) = $transxfunc.call(x)
def transy(y) = $transyfunc.call(y)

grid = makeGrid(nodes)

minx  = nodes.map(&:first).min
start = nodes.select{ it.first == minx }.min_by(&:last)

floodfill(grid, start)

best = rects.find{ rect(*it).all?{grid.include?(it)} }
puts "Part 2: #{size(best)}"
