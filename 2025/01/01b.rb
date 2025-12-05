input = File.readlines("01/input.txt")
            .map{ it.gsub("L", "-")}
            .map{ it.gsub("R", "+")}
            .map(&:to_i)
c = 0
v = 50
input.each do |i|
  i.abs.times do
    v += i<=>0
    v %= 100
    c += 1 if v == 0
  end
end

p c

