input = File.read("input.txt").split("\n")

width, height = input[0].size, input.size

cubes = Set.new
rocks = Set.new

height.times do |y|
  width.times do |x|
    cubes << [x,y] if input[y][x] == ?#
    rocks << [x,y] if input[y][x] == ?O
  end
end

sum = 0
rocks.sort_by{_1[1]}.each do |r|
  x, y = r[0], r[1]

  y -= 1 while y > 0 && !cubes.include?([x,y-1]) && !rocks.include?([x,y-1])
  rocks.delete(r)
  rocks << [x,y]

  sum += height-y
end

print sum
