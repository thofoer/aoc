numbers = {}
File.readlines("quadrat.txt").each_with_index do |l, y|
    l.split(" ").each_with_index do |z, x|        
        numbers[z.to_i] = Complex(x,y) if z != "__"
    end
end

class Grid
    attr_reader :map, :rev

    def initialize(map)
        @map = map        
        @rev = map.map{|k,v| [v,k]}.to_h
    end

    def adjacent(pos)
        [-1-1i, 0-1i, 1-1i, -1-0i, 1+0i, -1+1i, 0+1i, 1+1i].map{ it + pos }.filter{ it.imag.between?(0, 7) && it.real.between?(0, 7)}
    end

    def insert(num)
        last = @map[num-1]
        nxt = getnext(num)
        nxtpos = @map[nxt]
        delta = nxt - num
        pos = adjacent(last).reject{ dist(nxtpos, it) > delta }.reject{ @map.has_value?(it) }

        pos.map do |p|
            newmap = @map.dup            
            newmap[num] = p               
            newgrid = Grid.new(newmap)            
        end
    end

    def finished?
        @map.size == 64
    end

    def getcurrent
        i = 1
        i = i + 1 while @map.include?(i)                
        i
    end

    def getnext(i = 1)        
        i = i + 1 until @map.include?(i)
        i
    end

    def dist(a, b)
        dx = (a.real - b.real).abs
        dy = (a.imag - b.imag).abs
        min, max = [dx, dy].minmax
        min + (max - min)
    end

    def dump        
        8.times do |y|
            8.times do |x|
                s = @rev[Complex(x,y)]
                print s.nil? ? "__ " : "#{'%2d ' % s}"                
            end
            puts
        end
    end

end

grid = Grid.new(numbers)

queue = []
queue << grid

a = Set.new
z = 0
until queue.empty?         
    g = queue.pop  
    if g.finished?        
        g.dump
        a << g.map
        z = z + 1
        #puts "#{a.size} #{z}"
        #puts; next
        return
    end  
    
    g.insert(g.getcurrent).each{ queue << it }
end
