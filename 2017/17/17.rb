step = File.read("input.txt").to_i

a, x = [0], 0

2017.times do | i |    
    x =  (x + step + 1) % a.size
    a = a.insert(1 + x % a.size, i + 1)
end

puts a[1 + a.index(2017)]


result, x = 0, 0

50000000.times do | i |    
    x = (x + step + 1) % ( i + 1)
    result = i + 1 if x == 0    
end

puts result