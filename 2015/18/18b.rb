grid = File.readlines("input.txt", chomp: true)

W, H  = grid.size, grid[0].size
lights   = Set.new([Complex(0,0), Complex(0, W-1), Complex(H-1, 0), Complex(H-1, W-1)])
DIRS = [-1-1i, 0-1i, 1-1i, -1-0i, 1+0i, -1+1i, 0+1i, 1+1i]

W.times do |y|
  H.times do |x|    
    lights << Complex(x,y) if grid[y][x] == ?#
  end
end

def step(l)
    res = Set.new([Complex(0,0), Complex(0, W-1), Complex(H-1, 0), Complex(H-1, W-1)])
    W.times do |y|
        H.times do |x|    
            pos = Complex(x,y)
            n = DIRS.map{ l.include?(it + pos) }.count(true)

            res << pos if l.include?(pos) && n.between?(2, 3) || !l.include?(pos) && n == 3
        end
    end
    res
end

100.times do
    lights = step(lights)
end
p lights.size