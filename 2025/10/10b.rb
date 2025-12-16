input = File.readlines("sample.txt")
            .map{ it.scan(/\[(.+)\] ([()\d, ]+) {(.*)}/)}
            .flatten(1)
            .map{ |l,b,j| 
                        [
                            l.reverse.gsub(?.,?0).gsub(?#,?1).split("").map(&:to_i), 
                            b.scan(/\((.+?)\)/).flatten.map{ it.split(?,).map{1 << it.to_i}.reduce(&:|)},
                            j.split(?,).map(&:to_i)
                        ]
            }
def parity(jolts) = jolts.map{ it.odd? ? 1 : 0}

def value(pattern) = pattern.join.to_i(2)

def s(buttons, jolts)
    $cache = {}
    def solve1(buttons, pattern)
        v = value(pattern)
        $cache[v] ||= 0.step(by: 1).find{|c| buttons.combination(c).any?{ it.reduce(&:^) == v}}
    end
                    
    def solve2(buttons, jolts)
        par = parity(jolts)
        solve1(buttons, par)
    end

    solve2(buttons, jolts)
    
end

puts input.sum {|l,b| s(b,parity(l)) }
