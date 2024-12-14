races1 = [[51, 377], [69, 1171], [98, 1224], [78,1505]]
races2 = [[51699878, 377117112241505]]

def calc(time, dist)
  c = 0
  time.times do |i|
    c += 1 if i * (time - i) > dist
  end
  c
end

puts races1.map { |t, d| calc(t, d) }.inject(&:*)
puts races2.map { |t, d| calc(t, d) }.inject(&:*)