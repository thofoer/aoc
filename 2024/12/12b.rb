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
  rest = plot.dup
  @vertL, @vertR, @horiT, @horiB = [], [], [], []

  def insertVert(pos, list)
    found = false
    list.each do |side|
      if side.any?{|s| pos.real == s.real && [pos.imag-1, pos.imag+1].include?(s.imag)}
        side << pos
        found = true
      end
    end
    list << [pos] unless found
  end

  def insertHori(pos, list)
    found = false
    list.each do |side|
      if side.any?{|s| pos.imag == s.imag && [pos.real-1, pos.real+1].include?(s.real)}
        side << pos
        found = true
      end
    end
    list << [pos] unless found
  end

  v = rest.to_a.sort_by{|e| e.imag}
  until v.empty?
    pos = v.first
    v.delete(pos)
    insertVert(pos + (-1+0i), @vertL) if grid[pos + (-1+0i)] != plant
    insertVert(pos - (-1+0i), @vertR) if grid[pos - (-1+0i)] != plant

  end
  v = rest.to_a.sort_by{|e| e.real}
  until v.empty?
    pos = v.first
    v.delete(pos)
    insertHori(pos +  (0-1i), @horiT) if grid[pos +  (0-1i)] != plant
    insertHori(pos -  (0-1i), @horiB) if grid[pos -  (0-1i)] != plant
  end

  #puts "#{plant}: #{p.last.size}  #{@vertL.size + @vertR.size + @horiT.size + @horiB.size}"
  @vertL.size + @vertR.size + @horiT.size + @horiB.size
end

plots = findplots(grid)
price1 = plots.sum{| plant, plot| plot.size * plot.flat_map{|pos| ADJ.map{_1+pos}}.filter{grid[_1] != plant}.size}

#p price1
#countsides(grid, plots[3])

price2 = plots.sum{|plot| countsides(grid, plot) * plot.last.size}

p price2

# A region of R plants with price 12 * 10 = 120.
# A region of I plants with price 4 * 4 = 16.
# A region of C plants with price 14 * 22 = 308.
# A region of F plants with price 10 * !12! = 120.
# A region of V plants with price 13 * 10 = 130.
# A region of J plants with price 11 * 12 = 132.
# A region of C plants with price 1 * 4 = 4.
# A region of E plants with price 13 * 8 = 104.
# A region of I plants with price 14 * 16 = 224.
# A region of M plants with price 5 * 6 = 30.
# A region of S plants with price 3 * 6 = 18.
# Adding these together produces its new total price of