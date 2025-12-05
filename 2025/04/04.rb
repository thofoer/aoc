input = File.readlines("04/input.txt")

GRID = Set.new
input.each_with_index do |l, y|
  l.chars.each_with_index do |c, x|
    GRID << Complex(x,y) if c == ?@
  end
end

ADJ = [ -1-1i, -1+0i, -1+1i,  0-1i, 0+1i,  +1-1i, +1+0i, +1+1i]

def accessible(grid) = grid.reject{ |i| ADJ.map{it+i}.count{ grid.include?(it)} >=4 }

acc = accessible(GRID)
puts acc.count

g = GRID.dup
until acc.empty?
  g -= acc
  acc = accessible(g)
end
p GRID.count - g.count