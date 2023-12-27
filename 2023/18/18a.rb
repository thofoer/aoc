input = File.read("input.txt").split("\n").map {|l| l.scan(/([UDLR]) (\d+)/).to_a.flatten}
length = input.map{|p| p[1].to_i}.sum

dir = { "U" => 0-1i, "R" => 1+0i, "D" => 0+1i, "L" => -1+0i}

pos = 0+0i
path = []

input.each do |d,l|
    path << pos += dir[d] * l.to_i
end

area = path.reverse.each_cons(2).map{ |a,b|
  (b.real - a.real) * (b.imag + a.imag) >> 1  # https://de.wikipedia.org/wiki/Gau%C3%9Fsche_Trapezformel
}.sum

puts area + (length / 2) + 1    # https://de.wikipedia.org/wiki/Satz_von_Pick