input = File.readlines("sample2.txt")
            .map{ it.scan(/\[(.+)\] ([()\d, ]+) {(.*)}/)}
            .flatten(1)
            .map{ |l,b,j| 
                        [
                            l.gsub(?.,?0).gsub(?#,?1).split("").map(&:to_i), 
                            b.scan(/\((.+?)\)/).flatten.map{ it.split(?,).map{1 << it.to_i}.reduce(&:|)},
                            j.split(?,).map(&:to_i)
                        ]
            }
def parity(jolts)  = jolts.map{ it.odd? ? 1 : 0}
def value(pattern) = pattern.join.to_i(2)
def bits(value)   = value.to_s(2).count(?1)

def s(buttons, jolts)
    $cache = {}

    def solve1(buttons, pattern)
        p "pattern=#{pattern}"
        v = value(pattern)
        
        return $cache[v] if $cache.include?(v)

        res = []
        s = buttons.size
        
        0.upto((2 ** s)-1).each do |c|        

            #puts "c=#{c}"
            z = 0
            press = [0] * pattern.size
            0.upto(s-1).each do |i|        
                # puts "toggle #{c} #{1<<i} #{c&(1<<i)}  #{c&(1<<i) != 0} #{buttons[i]}"       
                if c&(1<<i) != 0 
                   
                    z ^= buttons[i] 
                    pattern.size.times do |j|
                        if buttons[i] & (1<<j) != 0
                            press[pattern.size-1-j] += 1
                        end
                    end
                end
            end
             #gets
            
            if z == v
              #   p "#{c.to_s(2)}  #{z}  #{v}"
                res << [c,press]
            end
        end
        res        
    end
                    
    def solve2(buttons, jolts)
        return 0 if jolts.all?(0)
        par = parity(jolts)
        res = solve1(buttons, par)        
        #res = count.map{bits(it)}.min
        # newjolts = jolts.zip(par).map{ it.inject(&:-)}
        # f = 1
        # while !newjolts.all?(0) && newjolts.all?(&:even?)
        #     f *= 2
        #     newjolts = newjolts.map{it/2}           
        # end
        # count.map{|z|

        # }
        
        
        
        # p "----->#{newjolts}"
        # f*res + solve2(buttons, newjolts)
    end

    solve2(buttons, jolts)
    
end


#p s(input[0][1],parity(input[0][0])) 
p s(input[0][1],input[0][2]) 

#puts input.sum {|l,b,j| s(b,parity(l)) }