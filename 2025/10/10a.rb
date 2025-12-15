input = File.readlines("input.txt")
            .map{ it.scan(/\[(.+)\] ([()\d, ]+) {(.+)}/)}
            .flatten(1)
            .map{ |l,b,j| 
                        [
                            l.reverse.gsub(?.,?0).gsub(?#,?1).to_i(2), 
                            b.scan(/\((.+?)\)/).flatten.map{ it.split(?,).map{1 << it.to_i}.reduce(&:|)}
                        ]
            }

z = input[2][0]
b = input[2][1]

p input.sum {|z,b| 0.upto(b.size-1).find{|c| b.combination(c).any?{ it.reduce(&:^) == z}} }
