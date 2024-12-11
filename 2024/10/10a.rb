input = File.read("input.txt").split("\n").map{ _1.split("").map(&:to_i)}

@grid = Hash.new
width = input.size
height = input[0].size
heads = []
tops = Set.new

width.times do |y|
  height.times do |x|
    pos = Complex(x,y)
    level = input[y][x]
    heads << pos if level==0
    tops  << pos if level==9
    @grid[pos] = level
  end
end

def reachable(head)
  search = [head]
  visited = Set.new

  until search.empty?
    pos = search.pop
    visited << pos

    [1+0i, -1+0i, 0+1i, 0-1i]
         .map{|n| [pos+n, @grid[pos+n]]}
         .filter{|r| r.last == @grid[pos]+1}
         .map(&:first)
         .each{ |p| search << p }
  end
  visited
end

p heads.sum{|h| tops.intersection(reachable(h)).size }
