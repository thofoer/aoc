input = File.read("input.txt").split("\n").map{_1.scan(/(-?\d+)/).flatten.map(&:to_f) }

P = lambda{ |a, b, u, v, c, d, r, s| (r*b - d*r - s*a + c*s) / (u*s - v*r)}
Q = lambda{ |a, b, u, v, c, d, r, s| (d*u - b*u - v*c + a*v) / (r*v - s*u)}

#AREA = 7..27
AREA = 200000000000000..400000000000000

def intersect?(a, b)
  x1, y1, _, vx1, vy1, _ = *a
  x2, y2, _, vx2, vy2, _ = *b
  f = Q.call(x1, y1, vx1, vy1, x2, y2, vx2, vy2)
  g = P.call(x1, y1, vx1, vy1, x2, y2, vx2, vy2)
  inX = x2 + f * vx2
  inY = y2 + f * vy2
  AREA.include?(inX) && AREA.include?(inY) && f > 0 && g > 0
end

puts input.combination(2).map { |a, b| intersect?(a,b) }.count(true)
