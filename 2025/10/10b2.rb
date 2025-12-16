input = File.readlines("input.txt")
            .map{ it.scan(/\[(.+)\] ([()\d, ]+) {(.*)}/)}
            .flatten(1)
            .map{ |l,b,j| 
                        [
                            l.gsub(?.,?0).gsub(?#,?1).chars.map(&:to_i), 
                            b.scan(/\((.+?)\)/).flatten.map{ it.split(?,).map(&:to_i)},
                            j.split(?,).map(&:to_i)
                        ]
            }
def parity(jolts)  = jolts.map{ it.odd? ? 1 : 0}
def value(pattern) = pattern.join.to_i(2)
def bits(value)   = value.to_s(2).count(?1)

t = input[0]    
pat = parity(t[2])


def solve1(buttons, pattern)
    v = value(pattern)    
    res = []
    bitcount = pattern.size
    s = buttons.size
    
    (2 ** s).times do |c|     
        z = 0
        but = []
        s.times do |i|
            if c&(1<<i) != 0                                 
                but << buttons[i]
                buttons[i].each do |b|                    
                    z ^= (1 << bitcount-b-1)                    
                end
            end
        end
        if z == v
            bv = but.flatten
            delta = 0.upto(bitcount-1).map{ bv.count(it) }
        
            res << [but.size, delta]
        end            
    end    
    res
end

def solve2(buttons, jolts)
    return 0 if jolts.all?(0)
    par = parity(jolts)
    res = solve1(buttons, par)   
    q = res.map{|count,delta| [count, jolts.zip(delta).map{|x,y| (x-y)/2}] }
           .reject{|count,delta| delta.any?{it<0}} 
    #p q  
    #gets   
    q = q.map{|count,newjolts| count + 2*solve2(buttons,newjolts)}
        
      #  count + 2*solve2(buttons, jolts.zip(delta).inject(&:-))
    #puts q
    #gets
    #p "return: #{q}"
    q.empty? ? 99999999 : q.min
end


t = input[1]    
o = t[0]


# Part 1
#p input.map{ solve1(it[1], parity(it[0])).map{|b,_| b}.min}.sum

p input[0..2].map{ solve2(it[1], it[2])}