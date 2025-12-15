nodes = File.readlines("sample.txt").map{it.split(?,).map(&:to_i)}

rect = nodes.combination(2).map{ [*it] }

def size(rec)
  (x1,y1), (x2,y2) = rec
  ((x1-x2).abs + 1) * ((y1-y2).abs + 1)
end

rs = rect.sort_by{size(it) }.reverse

nodes << nodes.first

GRID = Set.new
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

nodes.each_cons(2).each do |a,b| 
    rect(a,b).map{|x,y| point(x,y)}.each{ GRID << it}
end

(minx, maxx), (miny, maxy) = nodes.transpose.map(&:minmax)

px, py = nodes.select{ it.first == minx }.min_by(&:last)

queue = []
queue << point(px+1, py+1)

q = 0
until queue.empty?
  
    puts "#{q} #{queue.size}  #{GRID.size}" #if q%100000 == 0
    p queue
    gets
      q += 1
    n = queue.pop
        
    n1 = n+1
    n2 = n-1
    n3 = n+100000
    n4 = n-100000
    (GRID << n1; queue << n1) unless GRID.include?(n1)
    (GRID << n2; queue << n2) unless GRID.include?(n2)
    (GRID << n3; queue << n3) unless GRID.include?(n3)
    (GRID << n4; queue << n4) unless GRID.include?(n4)
    
end

0.upto(12) do |y|
    0.upto(12) do |x|
        if GRID.include?(point(x,y)) 
            print "#"        
        else
            print "."
        end
    end
    puts
end