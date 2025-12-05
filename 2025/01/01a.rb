input = File.readlines("01/input.txt")
            .map{ it.gsub("L", "-")}
            .map{ it.gsub("R", "+")}
            .map(&:to_i)
c = 0
v = 50
input.each do |i|
  v += i
  v %= 100
  c += 1 if v == 0
end

p c

