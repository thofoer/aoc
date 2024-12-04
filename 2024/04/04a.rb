input = File.read("input.txt").split("\n")
width = input.size
height = input[0].size
coords = {}

width.times do |y|
  height.times do |x|
    coords[Complex(x,y)] = input[y][x] 
  end
end

dir = [0+1i, 0-1i, 1+0i, -1+0i, 1+1i, 1-1i, -1+1i, -1-1i]

pattern = dir.map{ |d| (0..3).to_a.map{|e| e * d}}
  
p (0..width).to_a.product((0..height).to_a)
   .map{ |x,y| pattern.map{ |p| p.map{|q| Complex(x, y) + q}}   }
   .sum{ |a| a.count{ |z| z.map{ |c| coords[c]} == %w{X M A S}}}
  