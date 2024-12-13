input = File.read("input.txt").split("\n").map{ _1.split("")}

grid = {}
width, height = input.size, input[0].size

width.times do |y|
  height.times do |x|
    grid[Complex(x,y)] = input[y][x]
  end
end

ADJ = [-1+0i, 1+0i, 0-1i, 0+1i]

def findplots(g)
  plots = []
  grid = g.dup
  until grid.empty?
    pos, plant = grid.first
    plot = Set.new([pos])
    search = [pos]
    until search.empty? do
      pos = search.pop
      adj = ADJ.map{_1 + pos }.to_set - plot
      adj.filter{grid[_1] == plant}.each{plot << _1; search << _1;  }
    end
    plot.each{grid.delete(_1)}
    plots << [plant, plot]
  end
  plots
end

def countsides(grid, p)
  plant, plot = p
  @left, @right, @top, @bottom = [], [], [], []

  def insertside(pos, list, vertical)
    const, var = vertical ? [pos.real, pos.imag] : [pos.imag, pos.real]
    constF, varF = vertical ? [:real, :imag] : [:imag, :real]

    found = false
    list.each do |side|
      if side.any?{|s| const == s.send(constF) && [var-1, var+1].include?(s.send(varF))}
        side << pos
        found = true
      end
    end
    list << [pos] unless found
  end

  def findsides(grid, plot, plant, vertical)
    a = plot.to_a.sort_by{|e| vertical ? e.imag : e.real}
    delta = vertical ? -1+0i : 0-1i
    list1, list2 = vertical ? [@left, @right] : [@top, @bottom]
    until a.empty?
      pos = a.first
      a.delete(pos)
      insertside(pos + delta, list1, vertical) if grid[pos + delta] != plant
      insertside(pos - delta, list2, vertical) if grid[pos - delta] != plant
    end
  end

  findsides(grid, plot, plant, true)
  findsides(grid, plot, plant, false)

  @left.size + @right.size + @top.size + @bottom.size
end

plots = findplots(grid)
price1 = plots.sum{| plant, plot| plot.size * plot.flat_map{|pos| ADJ.map{_1+pos}}.filter{grid[_1] != plant}.size}

puts "Part 1: #{price1}"

price2 = plots.sum{|plot| countsides(grid, plot) * plot.last.size}

puts "Part 2: #{price2}"
