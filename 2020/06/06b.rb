print File.read("input.txt").split("\n\n").sum{ |s| s.split("\n").map{ Set[*_1.split("")] }.reduce(&:&).count }