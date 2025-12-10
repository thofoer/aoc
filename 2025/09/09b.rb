nodes = File.readlines("input.txt").map{it.split(?,).map(&:to_i)}

$Z = 2437
class Polygon
  attr_reader :edges, :outline
 
  def initialize(nodes)
    @edges = nodes.each_cons(2).map{|(x1, y1), (x2, y2)| Edge.new(x1, y1, x2, y2)}
    @outline = Set.new
    @edges.each do |e|
      e.points.each { outline << it}      
    end
    @cache = {}
  end 


  def pointWithin?(p, horizontal)    
    return @cache[p] if @cache.include?(p)    
    fix, var = horizontal ? [0, 1] : [1, 0]    
   # p "===> #{p}"
   # p "----> #{outline.select{ p[fix] == it[fix] && p[var] > it[var]}}"    
    # p outline.select{ p[fix] == it[fix] && p[var] > it[var]}.chunk_while{|i,j| i[var]+1==j[var]}.to_a
    res = outline.select{ p[fix] == it[fix] && p[var] > it[var]}.chunk_while{|i,j| i[var]+1==j[var]}.to_a.count % 2 == 1
    @cache[p] = res    
     res    
  end

  def check(rec)
    p "#{$Z} #{rec.inspect}"
    $Z += 1
    #p "horiz: #{rec.points(true).reject{ outline.include?(it)}.to_a.map{pointWithin?(it, false)}}"
    #p "vert : #{rec.points(false).reject{ outline.include?(it)}.to_a.map{pointWithin?(it, false)}}"
    rec.points(true) .reject{ outline.include?(it)}.to_a.shuffle.all?{ pointWithin?(it, true)} &&
    rec.points(false).reject{ outline.include?(it)}.to_a.shuffle.all?{ pointWithin?(it, false)} 
  end
end

class Edge
  attr_reader :x1, :y1, :x2, :y2

  def initialize(x1, y1, x2, y2)
    @x1, @y1, @x2, @y2 = x1, y1, x2, y2    
  end
  
  def inspect = "(#{x1},#{y1})-(#{x2},#{y2})"
  def horizontal? = x1 == x2

  def points
    if horizontal?
        a,b = [y1, y2].minmax
        a.upto(b).lazy.map {[x1, it]}
      else
        a,b = [x1, x2].minmax
        a.upto(b).lazy.map {[it, y1]}
      end
  end
end

class Rec
  attr_reader :left, :right, :top, :bottom, :size

  def initialize(n1, n2)
     (x1,y1), (x2,y2) = n1, n2
     x = [x1, x2]
     y = [y1, y2]
     @size   = ((x1-x2).abs + 1) * ((y1-y2).abs + 1)
     @left   = Edge.new(x.min, y.min, x.min, y.max)
     @top    = Edge.new(x.min, y.min, x.max, y.min)
     @right  = Edge.new(x.max, y.min, x.max, y.max)
     @bottom = Edge.new(x.min, y.max, x.max, y.max)
  end
  
  def inspect = "l: #{left.inspect}, t: #{top.inspect}, r: #{right.inspect}, b: #{bottom.inspect}, size: #{size}"

  def points(horizontal)
    enums = horizontal ? [top.points, bottom.points] : [left.points, right.points]
    Enumerator.new do |yielder|
      enums.each do |e|
        e.each {yielder << it }
      end
    end.lazy.uniq
  end
end

rect = nodes.combination(2).map{ Rec.new(*it) }
nodes << nodes.first
polygon = Polygon.new(nodes)



rs = rect.sort_by(&:size).reverse

#rs.each_with_index{|r,i| puts "#{i} #{r.inspect}  #{polygon.check(r)}"}
p rs.size
r = rs[$Z..].find{ polygon.check(it)}
p "--------------"
p r


#p polygon.check(r)

#"2242 l: (17755,10678)-(17755,84696), t: (17755,10678)-(77509,10678), r: (77509,10678)-(77509,84696), b: (17755,84696)-(77509,84696), size: 4423005345"
#"2243 l: (6780,27498)-(6780,86195), t: (6780,27498)-(82129,27498), r: (82129,27498)-(82129,86195), b: (6780,86195)-(82129,86195), size: 4422894300"
#"2244 l: (6780,27498)-(6780,87725), t: (6780,27498)-(80214,27498), r: (80214,27498)-(80214,87725), b: (6780,87725)-(80214,87725), size: 4422843180"
#"2245 l: (21386,11358)-(21386,88768), t: (21386,11358)-(78519,11358), r: (78519,11358)-(78519,88768), b: (21386,88768)-(78519,88768), size: 4422800074"

#"2294 l: (20511,11712)-(20511,91070), t: (20511,11712)-(76194,11712), r: (76194,11712)-(76194,91070), b: (20511,91070)-(76194,91070), size: 4419026556"
#"2295 l: (9943,15128)-(9943,76260), t: (9943,15128)-(82227,15128), r: (82227,15128)-(82227,76260), b: (9943,76260)-(82227,76260), size: 4418998905"
#"2296 l: (11983,14502)-(11983,78255), t: (11983,14502)-(81295,14502), r: (81295,14502)-(81295,78255), b: (11983,78255)-(81295,78255), size: 4418981002"
#"2297 l: (21868,11495)-(21868,88764), t: (21868,11495)-(79055,11495), r: (79055,11495)-(79055,88764), b: (21868,88764)-(79055,88764), size: 4418916760"

#"2434 l: (18162,13554)-(18162,72190), t: (18162,13554)-(93344,13554), r: (93344,13554)-(93344,72190), b: (18162,72190)-(93344,72190), size: 4408505571"
#"2435 l: (12579,19620)-(12579,79279), t: (12579,19620)-(86471,19620), r: (86471,19620)-(86471,79279), b: (12579,79279)-(86471,79279), size: 4408456380"
#"2436 l: (20591,20888)-(20591,86828), t: (20591,20888)-(87442,20888), r: (87442,20888)-(87442,86828), b: (20591,86828)-(87442,86828), size: 4408287732"
#"2437 l: (14668,12881)-(14668,80912), t: (14668,12881)-(79464,12881), r: (79464,12881)-(79464,80912), b: (14668,80912)-(79464,80912), size: 4408269504"