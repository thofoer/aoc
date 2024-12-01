input = File.read("input.txt")
            .split("\n")
            .map{|l| l.scan(/(\d+) +(\d+)/).flatten.map(&:to_i) }

a = input.map(&:first).sort
b = input.map(&:last).sort

puts a.zip(b).map{|x, y| (x - y).abs }.sum

puts a.map{ |e| e * b.count(e) }.sum