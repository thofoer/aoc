LIST = File.readlines("input.txt").map(&:to_i).reverse
sum  = LIST.sum

def solve(weight)
    (1..).each do |i|
        p = LIST.combination(i).reject{ it.sum != weight }
        unless p.empty?
            return p.map{ it.inject(&:*)}.min            
        end
    end
end

p solve(sum/3), solve(sum/4)