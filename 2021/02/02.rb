$input   = File.readlines("input.txt").map(&:split)
def value(type) = $input.select{|s,_| s == type}.map(&:last).sum(&:to_i) 

p value("forward") * (value("down") - value("up"))


pos, depth = $input.inject([0, 0, 0]) do |acc, line|
        (pos, depth, aim) = acc
        value = line.last.to_i
        case line.first
            when "down"    then aim += value
            when "up"      then aim -= value
            when "forward" then pos += value; depth += aim * value
        end            
        [pos, depth, aim]
    end
p pos * depth
