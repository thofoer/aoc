input = File.read("input.txt").split("\n\n")
RULES = input[0].split("\n").map { it.scan(/(\w+) => (\w+)/)}.flatten(1).group_by(&:first).map{|k,v| [k, v.map(&:last)]}.to_h
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

p step(input[1]).size
