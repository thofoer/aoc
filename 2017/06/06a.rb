a = File.read("input.txt").split("\t").map(&:to_i)
len = a.size

h = Set.new
h.add(a.dup)
step = 1

loop do
    maxIndex = a.index(a.max)
    value = a[maxIndex]
    a[maxIndex] = 0 
    value.times{ |i| a[(i+maxIndex+1) % len] += 1 }
    
    break if h.include?(a) 
    
    h.add(a.dup)    
    step += 1    
end

puts step