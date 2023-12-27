input = File.read("input.txt").split("\n")

@width, @height = input[0].size, input.size

@cubes = Set.new
@rocks = Set.new

@height.times do |y|
  @width.times do |x|
    @cubes << [x,y] if input[y][x] == ?#
    @rocks << [x,y] if input[y][x] == ?O
  end
end

def tiltNorth
  @rocks.sort_by{_1[1]}.each do |r|
    x, y = r[0], r[1]

    y -= 1 while y > 0 && !@cubes.include?([x,y-1]) && !@rocks.include?([x,y-1])
    @rocks.delete(r)
    @rocks << [x,y]

  end
end

def tiltSouth
  @rocks.sort_by{_1[1]}.reverse.each do |r|
    x, y = r[0], r[1]

    y += 1 while y < @height-1 && !@cubes.include?([x,y+1]) && !@rocks.include?([x,y+1])
    @rocks.delete(r)
    @rocks << [x,y]
  end
end

def tiltEast
  sum = 0
  @rocks.sort_by{_1[0]}.reverse.each do |r|
    x, y = r[0], r[1]

    x += 1 while x < @width-1 && !@cubes.include?([x+1,y]) && !@rocks.include?([x+1,y])
    @rocks.delete(r)
    @rocks << [x,y]
    sum += @height-y
  end
  sum
end

def tiltWest
  @rocks.sort_by{_1[0]}.each do |r|
    x, y = r[0], r[1]

    x -= 1 while x > 0 && !@cubes.include?([x-1,y]) && !@rocks.include?([x-1,y])

    @rocks.delete(r)
    @rocks << [x,y]
  end
end

def cycle
  tiltNorth
  tiltWest
  tiltSouth
  tiltEast
end

def findCycle(a)
  (1..(a.size/3)).each do |len|
    len.times do |dx|
      return [dx, len] if a[dx...(dx+3*len)].each_slice(len).uniq.size == 1
    end
  end
end

a = 400.times.map{ cycle }

start, len = findCycle(a)

r = (1000000000 - start) % len

puts a[start + r - 1]
