input = File.read("2020/15/input.txt").split(",").map(&:to_i)

def solve(input, max)
  hist = {}
  input[..-2].each.with_index { |n,i| hist[n.to_i]= i }

  v = input.last
  (input.size - 1...max-1).each do |i|
    a = hist[v]
    hist[v] = i
    v = a.nil? ? 0 : i - a
  end
  v
end

print "Part 1: #{solve(input, 2020)}\n"
print "Part 2: #{solve(input, 30000000)}\n"