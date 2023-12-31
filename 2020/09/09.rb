numbers = File.read("input.txt").split("\n").map(&:to_i)

N = 25

res = numbers[ N + numbers.each_cons(N + 1).map{ |*rest, n| rest.combination(2).map(&:sum).include?(n) }.index(false) ]
puts "Part 1: #{res}"

slice =  numbers[ (2..numbers.size - 1).map{ |i| (0...numbers.size - i).map{|j| (j..i+j) }}.flatten.find{|r| numbers[r].sum == res} ].sort
puts "Part 2: #{slice.first + slice.last}"
