input = File.read("input.txt").split("\n").map{ _1.scan(/(\d+)\-(\d+) (\w): (\w+)/).flatten }

puts input.count{ |min, max, letter, password| (min.to_i .. max.to_i).include?(password.count(letter))}

puts input.count{ |pos1, pos2, letter, password| (password[pos1.to_i - 1] == letter) ^ (password[pos2.to_i - 1] == letter)}

