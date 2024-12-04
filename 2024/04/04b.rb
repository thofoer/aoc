input = File.read("input.txt").split("\n")
width = input.size
height = input[0].size
grid = {}
coords = []

width.times do |y|
  height.times do |x|
    grid[Complex(x,y)] = input[y][x] 
    coords << Complex(x,y)
  end
end

MATCH = [%w{M S}, %w{S M}]
  
p coords.count{ |c| grid[c] == ?A && 
                    MATCH.include?([grid[c+(-1-1i)], grid[c+(1+1i)]]) && 
                    MATCH.include?([grid[c+(-1+1i)], grid[c+(+1-1i)]]) 
  }
