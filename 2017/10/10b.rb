input = File.read("input.txt")
L = 256

$lengths = input.each_byte.to_a + [17, 31, 73, 47, 23]

$a = (0...L).to_a
$skip = 0
$pos = 0

def swap(x,y)
  $a[x % L], $a[y % L] = $a[y % L], $a[x % L]
end

def reverse(start, len)
  (len/2).times.each{ |i| swap(start + i, start + len - i - 1) }
end

def doRound
  $lengths.each do | len |
    reverse($pos, len)
    $pos += len + $skip
    $skip += 1
  end
end

64.times{ doRound }

p $a.each_slice(16).map{ |c| c.inject(&:^)}.inject{|a, v|  a << 8 | v  }.to_s(16)

puts $a.each_slice(16)
       .map{ |c| c.inject(&:^)}
       .map{ |v| "%02x" % v }
       .join