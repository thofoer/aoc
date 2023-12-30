bags = File.read("input.txt").split("\n").map{ |s| s.gsub("no other", "").scan(/(\d*) ?([a-z]+ [a-z]+) bags?/) }
           .map{ |a| [a.first.last, a[1..].map{|n,c| [c, n.to_i]}.to_h] }.to_h

countBags = proc {|color| 1 + bags[color]&.sum{|k, v| v * countBags.call(k)} }

print countBags.call("shiny gold") - 1