input = File.read("input.txt").split("\n")
@width = input.size
@height = input[0].size
@grid = Set.new
@start = nil
@dirs = [0-1i, 1+0i, 0+1i, -1+0i]

@width.times do |y|
  @height.times do |x|
    case input[y][x]
    when ?#
      @grid.add Complex(x,y)
    when ?^
      @start = Complex(x,y)
    end
  end
end

def inbounds?(pos)
  pos.real.between?(0, @width-1) && pos.imag.between?(0, @height-1)
end

def findPath
  pos = @start
  dir = 0
  visited = Set[pos]
  while inbounds?(pos) do
    until @grid.include?(pos + @dirs[dir]) do
      pos += @dirs[dir]
      break unless inbounds?(pos)
      visited << pos
    end
    dir = (dir+1) % 4
  end
  visited
end

def hasCycle?(obstacle)
  @grid.add obstacle
  pos = @start
  dir = 0
  visited = Set[[pos, dir]]

  while inbounds?(pos) do
    until @grid.include?(pos + @dirs[dir]) do
      if visited.include?([pos + @dirs[dir], dir])
        @grid.delete(obstacle)
        return true
      end
      pos += @dirs[dir]
      break unless inbounds?(pos)
      visited << [pos, dir]
    end
    dir = (dir+1) % 4
  end
  @grid.delete(obstacle)
  false
end

path = findPath

puts "Part 1: #{path.size}"

path.delete(@start)

obstacles = path.map{|p| hasCycle?(p)}.count(true)

puts "Part 2: #{obstacles}"
