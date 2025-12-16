input = File.readlines("input.txt")
            .map{ it.scan(/\[(.+)\] ([()\d, ]+)/)}
            .flatten(1)
            .map{ |l,b| 
                        [
                            l.reverse.gsub(?.,?0).gsub(?#,?1).to_i(2), 
                            b.scan(/\((.+?)\)/).flatten.map{ it.split(?,).map{1 << it.to_i}.reduce(&:|)}
                        ]
            }

puts input.sum {|z,b| 1.upto(b.size).find{|c| b.combination(c).any?{ it.reduce(&:^) == z}} }
