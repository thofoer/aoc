input = File.read("input.txt").split("\n\n").map{ _1.split }

def smudge(a,b)
  (a ^ b).to_s(2).scan(/1/).to_a.size == 1
end

def matches(hashes)
  found = []
  hashes.size.times.each_cons(2) do |i, j|
    found << i if hashes[i] == hashes[j] || smudge(hashes[i], hashes[j])
  end

  found.each do |x|
    i, j = x, x + 1
    smudges = 0
    ok = true

    while ok && smudges <= 1 && i >= 0 && j < hashes.length
      if smudge(hashes[i], hashes[j])
        smudges += 1
      elsif hashes[i] != hashes[j]
        ok = false
      end
      i -= 1
      j += 1
    end
    return x + 1 if ok && smudges == 1
  end
  0
end

sum = 0

binary = lambda{ |s| s.gsub(?., ?0).gsub(?#, ?1).to_i(2) }

input.each do |a|
  horizontal = a.map(&binary)
  vertical   = a[0].length.times.map {|i| a.map{|x|x[i]}.join}.map(&binary)

  sum += 100 * matches(horizontal) + matches(vertical)
end

print sum