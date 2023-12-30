bags = File.read("input.txt").split("\n").map{ |s| s.scan(/([a-z]+ [a-z]+) bags?/).flatten}.map{|k, *v| [k, Set[*v]]}.to_h

containsGold = proc {|color| bags[color]&.include?("shiny gold") || bags[color]&.any?(&containsGold) }

print bags.keys.map(&containsGold).count(true)