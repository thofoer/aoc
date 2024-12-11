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

def rating(head)
  paths = Set.new
  search = [[head]]

  until search.empty?
    path = search.pop
    if path.size == 10
      paths << path
      next
    end
    pos = path.last

    [1+0i, -1+0i, 0+1i, 0-1i]
         .map{|n| [pos+n, @grid[pos+n]]}
             .filter{|r| r.last == @grid[pos]+1}
         .map(&:first)
         .map{ |p| path.dup << p }
         .each{ |z| search << z }
  end
  paths.size
end

p heads.sum{ rating(_1) }
