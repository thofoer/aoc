rules, input = File.read("input.txt").split("\n\n").map{|l| l.lines.map{it.scan(/\d+/).map(&:to_i)}}

p input.filter{ |l| rules.all?{|a,b| !l.include?(a) || !l.include?(b) || l.index(a) < l.index(b)}}
       .sum{it[it.size/2]}
       

