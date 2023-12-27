input = File.read("input.txt").split("\n").map(&:split).map{|l| l.map(&:to_i)}
print input
def calc(l)
    d, nl = [l], l    
    d.unshift nl = nl.each_cons(2).map{ |a, b| b - a } until nl.all?(0)
    d.map(&:last).reduce(&:+)
end

puts "Part 1: #{input.sum{ |l| calc(l) }}"
puts "Part 2: #{input.sum{ |l| calc(l.reverse) }}"
