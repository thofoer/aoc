grid = File.read("input.txt").split("\n")

START  = Complex(grid[0].index(?.), 0)
TARGET = Complex(grid[-1].index(?.), grid.size-1)

DIRS = [0-1i, 1+0i, 0+1i, -1+0i]

queue = [[START, Set[START]]]
max = 0
until queue.empty?
  pos, path = queue.shift

  max = path.size - 1 if pos == TARGET
    
  c = grid[pos.imag][pos.real]
  case c
  when ?<
    steps = Set[pos + -1+0i]
  when ?>
    steps = Set[pos + 1+0i]
  when ?v
    steps = Set[pos + 0+1i]
  else
    steps = DIRS.map{ pos + _1}.filter{ |p| grid[p.imag][p.real] != ?#}.to_set
  end

  (steps - path).each do |s|
    queue << [s, path.dup.add(s)]
  end

end

puts max
