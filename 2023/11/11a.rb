input = File.read("input.txt").split("\n")

@coords = []
@emptyRows = []
@emptyCols = []

input.size.times do |y|
  @emptyRows << y if input[y].index(?#).nil?
  input[y].size.times do |x|
    @coords << Complex(x,y) if input[y][x] == ?#
  end
end

input[0].size.times do |x|
  @emptyCols << x if input.map{_1[x]}.all?(?.)
end

def calc(factor = 1)
  @coords.combination(2).sum { |a,b|
    dx = a.real< b.real ? (a.real..b.real) : (b.real..a.real)
    dy = a.imag< b.imag ? (a.imag..b.imag) : (b.imag..a.imag)

    @emptyCols.count{dx.include? _1} * factor +
    @emptyRows.count{dy.include? _1} * factor +
    dx.size - 1 +
    dy.size - 1
  }  
end

puts "Part 1: #{calc}"
puts "Part 2: #{calc(999999)}"