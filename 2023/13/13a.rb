input = File.read("input.txt").split("\n\n").map{|a| a.split}

def matches(hashes)
  found = []
  hashes.size.times.each_cons(2) do |i,j|
    found << i if hashes[i] == hashes[j]
  end

  found.each do |i|
    len = [i+1, hashes.size-i-1].min
    return i+1 if hashes[0...len] == hashes[i+1..(i+len)].reverse ||
                  hashes[i+1..]   == hashes[((i-len+1)..i)].reverse
  end
  0
end

sum = 0
input.each do |a|
  horizontal = a.map{ |i|i.gsub(".","0").gsub("#", "1").to_i(2)}
  vertical   = a[0].length.times.map {|i| a.map{|x|x[i]}.join}.map{|i| i.gsub(?., ?0).gsub(?#, ?1).to_i(2)}

  sum += 100 * matches(horizontal) + matches(vertical)
end

print sum