$a, $b = File.read("input.txt").scan(/(\d+)/).flatten.map(&:to_i)

def nexta
    loop do
        $a = ($a * 16807) % 0x7FFFFFFF
        break if ($a & 3) == 0
    end
    $a
end

def nextb
    loop do
        $b = ($b * 48271) % 0x7FFFFFFF
        break if ($b & 7) == 0
    end
    $b
end

c = 0
5000000.times do
    c += 1 if nexta & 0xFFFF == nextb & 0xFFFF
end

print c