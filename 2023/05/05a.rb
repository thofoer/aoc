input = File.read("input.txt").split("\n\n")

seeds = input[0][6..].split.map(&:to_i)

maps = input[1..]
         .map{ |l| l.split("\n")}
         .map{ |a| a[1..].map(&:split).map{|i| i.map(&:to_i)}}

def mapTo(value, map)
  res = map.filter{ |_, s, l| value.between?(s, s+l-1)}.map{ |t, s, _| t+value-s}
  res.empty? ? value : res[0]
end

res = seeds.map { |s| 7.times { |i| s = mapTo(s, maps[i])}; s }

print res.min
