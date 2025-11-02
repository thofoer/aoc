map = {}
File.readlines("input.txt").map { it.scan(/(\w+) to (\w+) = (\d+)/).to_a.flatten}.each do | s, f, d|
    map[[s,f]] = d.to_i
    map[[f,s]] = d.to_i
end

cities = map.keys.map(&:first).to_set.to_a

min = 999999
max = 0
cities.permutation.each do |path|
   l = path.each_cons(2).sum{|x,y| map[[x,y]]}
   min = l if l < min
   max = l if l > max
end

p min
p max