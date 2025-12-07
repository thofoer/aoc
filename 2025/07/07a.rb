GRID  = File.readlines("input.txt").map(&:chars)
start = Complex(GRID[0].index(?S), 0)

beams = [start]
count = 0

(GRID.size-1).times do |o|
    nextBeams = []
    beams.each do |pos|
        if GRID[pos.imag+1][pos.real] == ?^
            nextBeams << pos + 1+1i
            nextBeams << pos - 1+1i            
            count += 1
        else
            nextBeams << pos + 0+1i
        end
    end
    nextBeams.uniq!    
    beams = nextBeams       
end
puts count 