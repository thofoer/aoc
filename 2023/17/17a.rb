
@grid = File.read("input.txt").split("\n").map{|l| l.split("").map(&:to_i)}
WIDTH  = (0...@grid[0].size)
HEIGHT = (0...@grid.size)
TARGET = Complex(WIDTH.max, HEIGHT.max)

NEXTDIRS = {"n": [:w, :e], "e": [:s, :n], "s": [:w, :e], "w": [:s, :n], nil => [:e, :s]}
STEPS    = {"n": 0-1i,     "e": 1+0i,     "s": 0+1i,     "w": -1+0i}

class State
    attr_accessor :pos, :value, :dir, :step
    def initialize(p, v, d, s)
        @pos, @value, @dir, @step = p, v, d, s
    end

    def <=>(other)      
        self.value <=> other.value 
    end
end

def inside?(c)
    WIDTH.include?(c.real) && HEIGHT.include?(c.imag)
end


def solve
    queue = [State.new((0+0i), 0, nil, 0)]
    visited = Set.new

    until queue.empty?
        a = queue.shift
        
        next if visited.include? [a.pos, a.dir, a.step]
        return a.value if a.pos == TARGET

        visited << [a.pos, a.dir, a.step]
    
        if (a.step < 3 && !a.dir.nil?) 
            nextPos = a.pos + STEPS[a.dir]            
            if inside? nextPos           
                queue << State.new(nextPos, a.value + @grid[nextPos.imag][nextPos.real], a.dir, a.step + 1)  
            end
        end
        
        NEXTDIRS[a.dir].each do |nextDir|
            nextPos = a.pos + STEPS[nextDir]            
            if inside? nextPos           
                queue << State.new(nextPos,  a.value + @grid[nextPos.imag][nextPos.real], nextDir, 1)                          
            end
        end
        queue.sort!
    end
    -1
end

puts solve