input = File.read("input.txt").split("\n")
width = input.size
height = input[0].size
antennas = Hash.new{ |h,k| h[k] = [] }

width.times do |y|
  height.times do |x|
    antennas[input[y][x]] << Complex(x,y) unless input[y][x] == ?.
  end
end

antinodes = Set.new

antennas.values.each do |a|
    a.combination(2) do |x,y|       
       diff = x-y       
       antinodes << x+diff << y-diff       
    end
end

p antinodes.count{|p| p.real.between?(0,width-1) && p.imag.between?(0,height-1)}
