input = File.read("input.txt").split("\n")
@width, @height = input.size, input[0].size
antennas = Hash.new{ |h,k| h[k] = [] }

@width.times do |y|
  @height.times do |x|
    antennas[input[y][x]] << Complex(x,y) unless input[y][x] == ?.
  end
end

def inbounds?(c) = c.real.between?(0, @width-1) && c.imag.between?(0, @height-1) 

antinodes1, antinodes2 = Set.new, Set.new

antennas.values.each do |a|
    a.combination(2) do |x,y|       
       diff = x-y
       f = 0
       while inbounds?(pos = x + f*diff) do
         antinodes1 << pos if f==1
         antinodes2 << pos
         f+=1
       end
       f = 0
       while inbounds?(pos = y - f*diff) do
         antinodes1 << pos if f==1
         antinodes2 << pos
         f+=1
       end       
    end
end

puts "Part 1: #{antinodes1.count}", "Part 2: #{antinodes2.count}"
