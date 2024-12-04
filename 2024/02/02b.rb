p File.read("input.txt")
            .split("\n")
            .map(&:split)
            .map{ |l| l.map(&:to_i) }
            .map{ |l| (0..l.size).map{|i| l.dup.tap{|e| e.delete_at(i)}}
                .map{ |l| l.each_cons(2).map{|a, b| a - b} }
            }
            .count{ |l| l.any? {|e| e.all?{ |b| b.between?(1, 3)} || e.all?{ |b| b.between?(-3, -1)}} }
            