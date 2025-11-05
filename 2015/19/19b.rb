require 'pairing_heap'
PrioQueue =  PairingHeap::MinPriorityQueue

input = File.read("input.txt").split("\n\n")
RULES = input[0].split("\n").map { it.scan(/(\w+) => (\w+)/)}.flatten(1).map{|a,b| [b,a]}.group_by(&:first).map{|k,v| [k, v.map(&:last)]}.to_h
target = input[1]

def step(molecule)
    #puts "----> #{molecule.inspect}"
    res = Set.new
    RULES.each do |k,v|
        indices = molecule.enum_for(:scan, Regexp.new("(#{k})")).map do
            Regexp.last_match.offset(0).first
        end    
        l = k.length
        v.each do |r|        
            indices.each do |i|
                m = molecule.dup
                m[i..(i+l-1)] = r
                res << m
            end
        end    
    end
    res
end

queue = PrioQueue.new
#target="HOHOHO"
queue.push [target, 0], target.length

seen = Set.new

while !queue.empty? do
    str, steps = queue.pop
    if str == ?e
        puts steps
        return
    end
    next if seen.include?(str)
    puts "#{steps} #{seen.size}  #{str}" if seen.size % 10000 == 0
    seen << str
    step(str).each do |n|
        state = [n, steps + 1]
        queue.push state, n.length * 1000 + steps unless queue.include?(state)
    end


end
