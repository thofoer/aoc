
nodes = File.readlines("input.txt").map{it.split(?,).map(&:to_i)}

rect = nodes.combination(2).map{ [*it] }

def size(rec)
  (x1,y1), (x2,y2) = rec
  ((x1-x2).abs + 1) * ((y1-y2).abs + 1)
end

rs = rect.sort_by{size(it) }.reverse

nodes << nodes.first

OUTLINE = Set.new
def point(x,y) = x*100000 + y

def rect(a,b)
    (x1, y1), (x2, y2) = a, b
    x1, x2 = [x1, x2].minmax
    y1, y2 = [y1, y2].minmax
    Enumerator.new do |yielder|
        x1.upto(x2).each { yielder << [it, y1] << [it, y2] }        
        (y1+1).upto(y2-1).each { yielder << [x1, it] << [x2, it] }         
    end
end

CACHE = {}

def within?(x,y)
    pnt = point(x,y)
    return true if OUTLINE.include?(pnt)
    return CACHE[pnt] if CACHE.include?(pnt)
    cross = 0
    d = false
    y.downto(0) do |i|
        inc = OUTLINE.include?(point(x,i))
        if (!d && inc)
            cross += 1
            d = true
        elsif (d && !inc)            
            d = false
        end
    end
    v1 = cross % 2 == 1

    cross = 0
    d = false
    x.downto(0) do |i|
        inc = OUTLINE.include?(point(i,y))
        if (!d && inc)
            cross += 1
            d = true
        elsif (d && !inc)            
            d = false
        end
    end
    v2 = cross % 2 == 1
    CACHE[pnt] = v1 && v2
end

nodes.each_cons(2).each do |a,b| 
    rect(a,b).map{|x,y| point(x,y)}.each{ OUTLINE << it}
end

M = rs.size
$Z = 50940
def check(a,b)
    p "#{$Z} #{'%.4f' % (100.0*$Z / M)}  #{a}-#{b}  #{size([a,b])}"
    $Z += 1
    rect(a,b).to_a.shuffle.all?{within?(*it)}
end

p rs.size

r = rs[$Z..].find{check(*it)}
p "--------------"
p r
# p size(r)

# p rs.size
# p OUTLINE.size
# p within?(6,5)

# 1.upto(9) do |y|
#     1.upto(12) do |x|
#         if OUTLINE.include?(point(x,y)) 
#             print "#"
#         elsif within?(x,y)
#             print "O"
#         else
#             print "."
#         end
#     end
#     puts
# end