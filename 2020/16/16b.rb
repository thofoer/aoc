input = File.read("input.txt").split("\n\n")

checkers = input.first.split("\n").map do |l|
    a1, b1, a2, b2 = *l.scan(/(\d+)\-(\d+) or (\d+)\-(\d+)/).flatten.map(&:to_i)
    lambda{|v| v.between?(a1, b1) || v.between?(a2, b2) }
end

ticket = input[1].scan(/(\d+)/).flatten.map(&:to_i)

valid = input.last[16..].split("\n").map{|l| l.split(",").map(&:to_i)}.select{|z| z.all?{|n| checkers.any?{|c| c.call(n)}}}

mapping = (0...ticket.size).map{ |i|
    slice = valid.map{|v| v[i]}
    checkers.map.with_index.select{|c,i| slice.all?{|s| c.call(s)}}.map(&:last)    
}.map{|s| Set[*s]}

indexes = mapping.map{|m| m - (mapping.find{|r| r.size == m.size - 1} || Set[])}.map(&:first)

print (0...6).map{|i| ticket[indexes.index(i)]}.reduce(&:*)