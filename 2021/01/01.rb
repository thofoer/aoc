input = File.readlines("input.txt").map(&:to_i)

p input.each_cons(2).count{|a,b| b > a}
p input.each_cons(3).map(&:sum).each_cons(2).count{|a,b| b > a}