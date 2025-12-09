POLYGON = File.readlines("09/input.txt").map{it.split(?,).map(&:to_i)}

def size(rec)
  (x1,y1), (x2,y2) = rec
  ((x1-x2).abs + 1) * ((y1-y2).abs + 1)
end

rectangles = POLYGON.combination(2).sort_by{-size(it) }

puts size(rectangles.first)

def within?(rec)
  true
end

puts size(rectangles.find{within?(it)})
