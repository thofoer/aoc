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
            when 0 then a = a / 2 ** combo            
            when 1 then b ^= v            
            when 2 then b = combo % 8            
            when 3 then i = (a!=0 ? v-2 : i)
            when 4 then b = b ^ c
            when 5 then out << combo % 8            
            when 6 then b = a / 2 ** combo            
            when 7 then c = a / 2 ** combo         
        end
        i+=2
        return out if i >= @prg.size        
    end
end

def search(pos, a)
    return a if func(a)==@prg
    f = (0..7).to_a.filter{ |c| func(a | c << 3*pos ) [pos] == @prg[pos] }
    f.map{|j| search(pos-1, a | j << 3*pos)}             
end

puts func(regA).map(&:to_s).join(?,)
puts search(15, 0).flatten.min
