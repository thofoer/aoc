$a, $b = File.read("input.txt").scan(/(\d+)/).flatten.map(&:to_i)

def nexta = $a = ($a * 16807) % 0x7FFFFFFF

def nextb = $b = ($b * 48271) % 0x7FFFFFFF

c = 0
40000000.times do
    c += 1 if nexta & 0xFFFF == nextb & 0xFFFF
end

print c