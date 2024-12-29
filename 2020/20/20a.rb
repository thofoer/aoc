def toNumber(s) = s.gsub(?., ?0).gsub(?#, ?1).to_i(2)

tiles = File.read("sample.txt").split("\n\n").map do |p|
    name, *tile = p.split("\n")
    number = name.scan(/\d+/).flatten.first.to_i
   
    top = tile.first
    bottom = tile.last
    left  = tile.map{ _1[0]  }.join
    right = tile.map{ _1[-1] }.join

    res = Set.new
    [top, bottom, left, right].each do |s|
        res << toNumber(s) << toNumber(s.reverse)        
    end
    [res, number]
end.to_h

all = Set[* tiles.keys]

adj = tiles.map{|k,v|    
    others = (all - Set[k] ).reduce(&:+)
   [ (others & k).size / 2, v]
}

puts adj.select{|c,_| c==2}.map(&:last)