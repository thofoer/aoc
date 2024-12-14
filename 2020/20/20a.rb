def toNumber(s)
    s.gsub(?., ?0).gsub(?#, ?1).to_i(2)
end

tiles = File.read("input.txt").split("\n\n").map do |p|
    name, *tile = p.split("\n")
    number = name.scan(/\d+/).flatten.first.to_i

    top = tile.first
    buttom = tile.last
    left  = tile.map{ |z| z[0]  }.join
    right = tile.map{ |z| z[-1] }.join

    res = Set.new
    [top, buttom, left, right].each do |s|
        res << toNumber(s) << toNumber(s.reverse)        
    end
    [res, number]
end.to_h

all = Set[* tiles.keys]

adj = tiles.map{|k,v|    
    others =  (all - Set[k] ).reduce(&:+)
   [ (others & k).size / 2, v]
}

print adj.select{|c,_| c==2}.map(&:last).reduce(&:*)