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

dir = [0+1i, 0-1i, 1+0i, -1+0i, 1+1i, 1-1i, -1+1i, -1-1i]

pattern = dir.map{ |d| (0..3).to_a.map{|e| e * d}}
  
p coords
   .map{ |c| pattern.map{ |p| p.map{|q| c + q}}   }
   .sum{ |a| a.count{ |z| z.map{ |c| grid[c]} == %w{X M A S}}}
  