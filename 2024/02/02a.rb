p File.read("input.txt")
            .split("\n")
            .map(&:split)
            .map{ |l| l.map(&:to_i) }
            .map{ |l| l.each_cons(2).map{|a, b| a - b} }
            .count{ |l| l.all?{ |e| e.between?(1, 3)} || l.all?{ |e| e.between?(-3, -1)}}
            
            