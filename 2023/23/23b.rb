@grid = Set.new
File.read("input.txt").each_line(chomp: true).with_index do |l, y|
  l.each_char.with_index do |c, x|
    @grid << Complex(x,y) if c != ?#
  end
end

sortedByY = @grid.sort_by(&:imag)

START  = sortedByY.first
TARGET = sortedByY.last
DIRS   = [0-1i, 1+0i, 0+1i, -1+0i]

def adjacent(pos)
  DIRS.map{ pos + _1}.to_set & @grid
end

@nodes = [START, @grid.select{ |c| adjacent(c).size >= 3}, TARGET].flatten

def distance(start, target)
  visited = Set[start]
  queue = adjacent(start).map{ [_1, 1]}

  until queue.empty?
    pos, length = queue.shift
    return length if pos == target
    next if @nodes.include? pos

    visited << pos
    queue << [(adjacent(pos) - visited).first, length + 1]
  end
end

def makeEdges
  edges = @nodes.map{ [_1, Hash.new]}.to_h

  @nodes.combination(2).each do |n1, n2|
    next if edges[n1].size > 3 || edges[n2].size > 3
    dist = distance(n1, n2)
    edges[n1][n2] = dist unless dist.nil?
    edges[n2][n1] = dist unless dist.nil?
  end
  edges
end

edges = makeEdges
queue = [[START, [START], 0]]
max = 0

until queue.empty?
  node, path, length = queue.shift
  max = length if node == TARGET && max < length

  edges[node].each do |adj, l|
    queue << [adj, path+[adj], length + l] unless path.include? adj
  end
end

puts max