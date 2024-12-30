a = File.read("input.txt").split("\t").map(&:to_i)
len = a.size

h = Hash.new
h[a.dup] = 0
step = 1

loop do
    maxIndex = a.index(a.max)
    value = a[maxIndex]
    a[maxIndex] = 0 
    value.times{ |i| a[(i+maxIndex+1) % len] += 1 }
    
    break if h.include?(a) 
    
    h[a.dup] = step
    step += 1    
end

puts step - h[a]