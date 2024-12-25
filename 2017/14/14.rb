input = File.read("input.txt")
L = 256

def hash(code)

    $lengths = code.each_byte.to_a + [17, 31, 73, 47, 23]

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

    $a.each_slice(16).map{ |c| c.inject(&:^)}.inject{|a, v|  a << 8 | v  }
end

$grid = Set.new

(0..127).each do |y|
    ("%128b" %hash("#{input}-#{y}")).each_byte.with_index do |n, x|
        $grid << Complex(x,y) if n == 49
    end
end

puts $grid.size

DIRS = [-1+0i, 0-1i, 1+0i, 0+1i]

def removeRegion
    queue = [$grid.first]
    until queue.empty?
        pos = queue.pop
        $grid.delete(pos)
        DIRS.map{|d| d+pos}.select{|p| $grid.include?(p)}.each{ queue << _1 }
    end
    
end
count = 0
(removeRegion; count += 1) until $grid.empty?

puts count

