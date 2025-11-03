TIME = 2503
input = File.readlines("input.txt").map { it.scan(/(\d+).* (\d+).* (\d+)/).to_a.flatten.map(&:to_i)}

def dist(t, v, d, r)
    full = v * (t / (d + r)) * d
    rem = t % (d + r)
    add = rem >= d ? d * v : rem * v
    full + add
end

p input.map{ dist(TIME, *it) }.max

res = 1.upto(TIME).map{|t| input.map{|a| dist(t, *a)}}.map do |race|
    max = race.max
    race.each_with_index.select{|v,_| v==max}.map(&:last)
end

p res.flatten.tally.values.max