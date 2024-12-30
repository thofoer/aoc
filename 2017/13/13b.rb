input = File.readlines("input.txt")

@scan = []

input.each do | line | 
    line.scan(/(\d+): (.*)$/) do | p, l|
      @scan[p.to_i] = l.to_i
    end
end

def check(d)    
    @scan.each_with_index do |v, i|        
        return false if v && ((i+d) % ((v-1)*2)) == 0            
    end
    true
end

w = 1
w += 1 until check(w) 

puts w