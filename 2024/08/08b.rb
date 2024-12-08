input = File.read("input.txt").split("\n")
@width = input.size
@height = input[0].size
antennas = Hash.new{ |h,k| h[k] = [] }

@width.times do |y|
  @height.times do |x|
    antennas[input[y][x]] << Complex(x,y) unless input[y][x] == ?.
  end
end

def inbounds(c)
  c.real.between?(0,@width-1) && c.imag.between?(0,@height-1)
end

antinodes = Set.new

antennas.values.each do |a|
    a.combination(2) do |x,y|       
       diff = x-y
       f = 0
       while inbounds(x+f*diff) do
         antinodes << x+f*diff
         f+=1
       end
       f = 0
       while inbounds(y-f*diff) do
         antinodes << y-f*diff
         f+=1
       end       
    end
end

p antinodes.count
