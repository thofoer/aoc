input = File.read("input.txt").split("\n")
H = input.size
W = input[0].size

TRANS = {:clean => :weak, :weak => :infected, :infected => :flagged, :flagged => :clean}

grid = Hash.new(:clean)

input.each.with_index do |l,y|
    l.each_byte.with_index do |b,x|
        grid[Complex(x,y)] = :infected if b == 35
    end
end

def dump(grid)
    minX, maxX = grid.keys.map(&:real).minmax
    minY, maxY = grid.keys.map(&:imag).minmax
    (minY-2..maxY+2).each do |y|
        (minX-2..maxX+2).each do |x|
             
            case grid[Complex(x,y)]
            when :clean then print ?.
            when :infected then print ?#
            when :weak then print ?W
            when :flagged then print ?F
            end
            print " "
        end
        puts
    end
end

pos = Complex(W/2, H/2)

DIRS = [0-1i, -1+0i, 0+1i, 1+0i]
dir = 0
count = 0

10000000.times do
    
    dir += 1 if grid[pos] == :clean 
    dir -= 1 if grid[pos] == :infected
    dir += 2 if grid[pos] == :flagged
    dir %= 4
    grid[pos] = TRANS[grid[pos]]
    count += 1 if grid[pos] == :infected
    pos += DIRS[dir]
end

p count
#dump(grid)