
sss = Time.now

a = Set.new

1000000.times do |i|
  a << Complex(i,i)
end

z = 0
500000.times do |i|
  z += 1 if a.include?(Complex(i,i+1)) || a.include?(Complex(i,i))
end
p z
p Time.now - sss

sss = Time.now

b = Set.new

1000000.times do |i|
  b << i.to_s
end

z = 0
500000.times do |i|
  z += 1 if b.include?("to_s") || b.include?(i.to_s)
end
p z
p Time.now - sss


sss = Time.now

c = Set.new

1000000.times do |i|
  c << [i,i]
end

z = 0
500000.times do |i|
  z += 1 if c.include?([i, i+1]) || c.include?([i,i])
end
p z
p Time.now - sss

sss = Time.now
d = Set.new

1000000.times do |i|
  d << i
end

z = 0
500000.times do |i|
  z += 1 if d.include?(-i) || d.include?(i)
end
p z
p Time.now - sss

sss = Time.now
e = Set.new
Pos = Struct.new(:x, :y)

1000000.times do |i|
  e << Pos.new(i,i)
end

z = 0
500000.times do |i|
  z += 1 if e.include?( Pos.new(i,i+1)) || e.include?( Pos.new(i,i))
end
p z
p Time.now - sss