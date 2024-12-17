regA, prg = File.read("input.txt").scan(/Register A: (\d+).*Program: (.*)/m).flatten

regA = regA.to_i
@prg = prg.split(?,).map(&:to_i)

def func(a)
    b, c, i = 0, 0, 0    
    out = []
    
    loop do    
        op, v = @prg[i..i+1]        
        combo = [0, 1, 2, 3, a, b, c][v]
        
        case op
        when 0
            a = a / 2 ** combo            
        when 1
            b ^= v            
        when 2
            b = combo % 8            
        when 3
            i = (a!=0 ? v-2 : i)
        when 4
            b = b ^ c
        when 5
            out << combo % 8            
        when 6
            b = a / 2 ** combo            
        when 7
            c = a / 2 ** combo         
        end
        i+=2
        return out if i >= @prg.size        
    end
end

def search(start, rightHalf)
    offset, range = rightHalf ? [24, 8..] : [0, 0..]    
    result = Float::INFINITY

    (0..7).to_a.repeated_permutation(8).each do |digits| 
        a = digits.map.with_index{|d, i| d << ((3*i)+offset) }.inject(&:|) | start        
        result = [result, a].min if func(a)[range] == @prg[range]                                                       
    end
    result
end

puts func(regA).map(&:to_s).join(?,)
puts search(search(0, true), false)
