@input = File.read("input.txt")
            .scan(/.*?X\+(\d+), Y\+(\d+).*?X\+(\d+), Y\+(\d+).*?X=(\d+), Y=(\d+)/m)
            .map{ _1.map(&:to_f)}

X = lambda{ |a, b, c, d, e, f| (e*c - b*f) / (e*a - b*d) }
Y = lambda{ |a, b, c, d, e, f| (a*f - c*d) / (e*a - b*d) }

def tokens(offset=0) =
  @input.map { |ax, ay, bx, by, px, py| 3 * X.call(ax, bx, px+offset, ay, by, py+offset) +
                                                 Y.call(ax, bx, px+offset, ay, by, py+offset) }
       .filter{ _1 == _1.truncate}
       .sum
       .to_i

p tokens
p tokens(10000000000000)