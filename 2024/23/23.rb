input = File.read("input.txt").scan(/(..)\-(..)/)

$map = Hash.new {|h,k| h[k] = Set.new}

input.each do |a,b|
    $map[a]<<b    
    $map[b]<<a
end

nets = Set.new
$map.keys.each do |k|
    $map[k].to_a
           .combination(2)
           .select{ |a,b| $map[a].include?(b)}
           .each{ |a,b| nets << Set.new([k, a, b])}
end

puts nets.count{ |c| c.any?{|n| n.start_with?(?t)}}

def findmax(len)
    $map.each do |k,v|        
        f = v.to_a
             .combination(len)
             .find{ |m| m.combination(2).all?{ |a,b| $map[a].include?(b)}}

        (puts [*f, k].sort.join(?,); return true) if f
    end
    false 
end

$map.values.map(&:size).max.downto(1).find{ findmax(_1) }