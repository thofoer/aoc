rules, input = File.read("input.txt").split("\n\n").map{|l| l.lines.map{it.scan(/\d+/).map(&:to_i)}}

incorrect = input.filter{ |l| !rules.all?{|a,b| !l.include?(a) || !l.include?(b) || l.index(a) < l.index(b)}}

p incorrect.map{ |l| [l, rules.filter{|a,b| l.include?(a) && l.include?(b)}] }
           .map{ |l,r| l.map{|n| [n,r.map(&:first).count(n)]} }
           .map{ it.sort_by(&:last).map(&:first) }
           .sum{ it[it.size/2] }