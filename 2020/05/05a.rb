print File.read("input.txt").split("\n").map{ _1.gsub(/R|B/, "1").gsub(/F|L/, "0").to_i(2)}.max