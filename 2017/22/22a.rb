input = File.read("input.txt").split("\n")
H = input.size
W = input[0].size

grid = Set.new

input.each.with_index do |l,y|
    l.each_byte.with_index do |b,x|
        grid << Complex(x,y) if b == 35
    end
end

def dump(grid)
    minX, maxX = grid.map(&:real).minmax
    minY, maxY = grid.map(&:imag).minmax
    (minY-2..maxY+2).each do |y|
        (minX-2..maxX+2).each do |x|
            print grid.include?(Complex(x,y)) ? ?# : ?., " "
        end
        puts
    end
end

pos = Complex(W/2, H/2)

DIRS = [0-1i, -1+0i, 0+1i, 1+0i]
dir = 0
count = 0

10000000.times do
    dir = (dir + (grid.include?(pos) ? -1 : 1)) % 4
    if grid.include?(pos)
        grid.delete(pos)
    else
        grid << pos
        count += 1
    end
    pos += DIRS[dir]
    
end

#dump(grid)
puts count