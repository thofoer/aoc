@plots = Set.new
start = nil
File.read("input.txt").each_line.with_index do |l, y|
  l.each_char.with_index do |c, x|
    @plots << Complex(x,y) unless c == ?#
    start = Complex(x,y) if c == ?S
  end
end

DIRS = [ 0-1i, 1+0i, 0+1i, -1+0i]
SIZE = 0..@plots.map(&:real).max

def dump(a, pos)
  SIZE.each do |y|
    SIZE.each do |x|
      print pos.include?(Complex(x,y)) ? ?O : a.include?(Complex(x,y)) ? ?. : ?#
    end
    puts
  end
end

def step(start)
  res = Set.new
  start.each do |p|
    DIRS.each do |d|
      n = d + p
      res << n if @plots.include?(n) && SIZE.include?(n.real) && SIZE.include?(n.imag)
    end
  end
  res
end

s = [start]

64.times do
  s = step(s)
end

puts s.size