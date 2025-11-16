INPUT = File.readlines("input.txt").map(&:to_i)

p INPUT.sum

def solve
    seen = Set.new
    s = 0
    INPUT.cycle.each do |v|
        s += v
        return s if seen.include? s    
        seen.add s
    end
end

p solve