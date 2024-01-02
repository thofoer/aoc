@seats = {}
File.read("input.txt").each_line.with_index do |l,y|
  l.each_char.with_index do |c,x|
    @seats[Complex(x,y)] = false if c == ?L
  end
end

WIDTH  = 0..@seats.keys.map(&:real).max
HEIGHT = 0..@seats.keys.map(&:imag).max

def inside?(p)
  WIDTH.include?(p.real) && HEIGHT.include?(p.imag)
end

def adjacent(p)
  [-1-1i, 0-1i, 1-1i, 1+0i, 1+1i, 0+1i, -1+1i, -1+0i].map{|d| @seats[p + d * (1..).find{|i| !(@seats[ i * d + p].nil? && inside?(i * d + p) )}] }.count(true)
end

def step
  newSeats = @seats.dup
  @seats.keys.each do |p|
    newSeats[p] = true  if adjacent(p) == 0
    newSeats[p] = false if adjacent(p) >= 5
  end
  changed = @seats !=  newSeats
  @seats = newSeats
  changed
end

while step do end

puts @seats.values.count(true)

