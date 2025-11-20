input = File.readlines("input.txt")            
            .map{it.scan(/(\d+)/).flatten.map(&:to_i)}

a = input.map(&:first).sort
b = input.map(&:last).sort

puts a.zip(b).sum{|x, y| (x - y).abs }
puts a.sum{ it * b.count(it) }