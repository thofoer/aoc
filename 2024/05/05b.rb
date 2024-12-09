rules, input = File.read("input.txt").split("\n\n").map{|l| l.split("\n")}
starting = Time.now

rules = rules.map{ _1.split("|")}
input = input.map{ _1.split(",")}

incorrect = input.filter{ |l| !rules.all?{|a,b| !l.include?(a) || !l.include?(b) || l.index(a) < l.index(b)}}

p incorrect.map{ |l| [l, rules.filter{|a,b| l.include?(a) && l.include?(b)}]}
           .map{ |l,r| l.map{|n| [n,r.map(&:first).count(n)]}}
           .map{ |p| p.sort_by(&:last).map(&:first)}
           .map{ _1[_1.size/2]}
           .sum(&:to_i)

ending = Time.now

p  ending - starting