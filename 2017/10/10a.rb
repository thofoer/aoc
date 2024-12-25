input = File.read("input.txt").split(?,).map(&:to_i)
L = 256

$a = (0..L).to_a
skip = 0
pos = 0

def swap(x, y)
  $a[x % L], $a[y % L] = $a[y % L], $a[x % L]
end

def reverse(start, len)
  (len/2).times.each{ |i| swap(start + i, start + len - i - 1) }
end

input.each do | len |
  reverse(pos, len)
  pos += len + skip
  skip += 1
end

puts $a[0] * $a[1]