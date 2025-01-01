$map = Hash.new{|h,k| h[k] = Set.new}
File.readlines("input.txt", chomp: true).map{it.split(?/).map(&:to_i)}.each do |a,b|
    $map[a] << b
    $map[b] << a
end

def bridges(b = [0, 0])
    Enumerator.new do |yielder|
        current = b.last[1]
        $map[current].each do |n|
            t = b.each_cons(2).to_a.flatten(1)           
            unless t.any?([current,n]) || t.any?([n,current])
                newbridge = b.dup << [current, n]
                yielder << newbridge
                bridges(newbridge).each{ yielder << it }
            end
        end        
    end
end

result = bridges.map{ [it.size, it.flatten.inject(&:+)] }

p result.map(&:last).max
p result.sort.last.last