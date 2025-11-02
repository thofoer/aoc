strings = File.readlines("input.txt", chomp: true)

l = strings.sum(&:length)
n = strings.sum{it.gsub("\\\\", ?.).gsub("\\\"", ?.).gsub(/\\x\h\h/, ?.).length - 2}
c = strings.map(&:inspect).sum(&:length)

puts l - n
puts c - l
