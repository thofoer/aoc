rules, input = File.read("input.txt").split("\n\n").map{|l| l.split("\n")}

rules = rules.map{ _1.split("|")}
input = input.map{ _1.split(",")}

p input.filter{ |l| rules.all?{|a,b| !l.include?(a) || !l.include?(b) || l.index(a) < l.index(b)}}
       .map{_1[_1.size/2]}
       .sum{ _1.to_i}

