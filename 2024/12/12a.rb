input = File.read("input.txt").split("\n").map{ _1.split("")}

grid = {}
width, height = input.size, input[0].size

width.times do |y|
  height.times do |x|
    grid[Complex(x,y)] = input[y][x]
  end
end

ADJ = [-1+0i, 1+0i, 0-1i, 0+1i]
plots = []
g = grid.dup
until g.empty?
  pos, plant = g.first
  plot = Set.new([pos])
  search = [pos]
  until search.empty? do
    pos = search.pop
    adj = ADJ.map{_1 + pos }.to_set - plot
    adj.filter{g[_1] == plant}.each{plot << _1; search << _1;  }
  end
  plot.each{g.delete(_1)}
  plots << [plot, plant]
end

p plots.sum{|plot, plant| plot.size * plot.flat_map{|pos| ADJ.map{_1+pos}}.filter{grid[_1]!=plant}.size}

