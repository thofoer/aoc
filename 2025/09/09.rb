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
            if grid.include?(point(x,y)) 
                file.print "#"        
            else
                file.print "."
            end
        end
        file.puts
    end
    file.close
end

def rect(a, b)
    (x1, y1), (x2, y2) = a, b
    x1, x2 = [x1, x2].minmax.map{transx(it)}
    y1, y2 = [y1, y2].minmax.map{transy(it)}
    Enumerator.new do |yielder|
        x1.upto(x2).each { yielder << [it, y1] << [it, y2] }        
        (y1+1).upto(y2-1).each { yielder << [x1, it] << [x2, it] }         
    end
end

rs = sortedRects(nodes)
puts "Part 1: #{size(rs.first)}"

def makeGrid(nodes)
    grid = Set.new
    nodes.each_cons(2).each do |a,b|     
        rect(a,b).each{ grid << it }
    end    
    grid
end

def makeTransposeFunctions(nodes)
    xs, ys = nodes.transpose.map(&:uniq!).map(&:sort)

    compx = xs.zip(1.step(by: 2)).to_a.to_h
    compy = ys.zip(1.step(by: 2)).to_a.to_h
    [lambda{ |x|compx[x] }, lambda{|y| compy[y] }]
end

def floodfill(grid, start)
    px = transx(start[0])
    py = transy(start[1])
    queue = []
    queue << [px+1, py+1]

    until queue.empty?
        n = queue.pop
            
        n1 = [n[0],n[1]+1]
        n2 = [n[0]+1,n[1]]
        n3 = [n[0]-1,n[1]]
        n4 = [n[0],n[1]-1]
        
        (grid << n1; queue << n1) unless grid.include?(n1)
        (grid << n2; queue << n2) unless grid.include?(n2)
        (grid << n3; queue << n3) unless grid.include?(n3)
        (grid << n4; queue << n4) unless grid.include?(n4)
    end
end

$transxfunc, $transyfunc = makeTransposeFunctions(nodes)

def transx(x) = $transxfunc.call(x)
def transy(y) = $transyfunc.call(y)


grid = makeGrid(nodes)

minx  = nodes.map(&:first).min
start = nodes.select{ it.first == minx }.min_by(&:last)

floodfill(grid, start)

best = rs.find{ rect(*it).all?{grid.include?(it)}}
puts "Part 2: #{size(best)}"

