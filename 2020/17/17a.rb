require "Matrix"

grid = Set.new
input = File.read("input.txt").split("\n")
input.each.with_index do |l, y|
    l.each_char.with_index do |c,x|
        grid << Vector[x,y,0] if c == ?#
    end
end

OFFSETS = (-1..1).map{|x| (-1..1).map{|y| (-1..1).map{|z| Vector[x,y,z]}}}.flatten(2)
OFFSETS.delete(Vector[0,0,0])


def neighbours(coord, grid)
    OFFSETS.map{|o| grid.include?(coord + o)}.count(true)
end

@xrange = 0..input.first.size-1
@yrange = 0..input.size-1
@zrange = 0..0

def step(grid)
    @xrange = @xrange.min-1..@xrange.max+1
    @yrange = @yrange.min-1..@yrange.max+1
    @zrange = @zrange.min-1..@zrange.max+1

    coords = @xrange.map{|x| @yrange.map{|y| @zrange.map{|z| Vector[x,y,z]}}}.flatten(2)
    newGrid = Set.new

    coords.each do |c|
        newGrid << c if grid.include?(c) && [2,3].include?(neighbours(c, grid))
        newGrid << c if !grid.include?(c) && neighbours(c, grid) == 3
    end
    newGrid
end

6.times{ grid = step(grid) }
print grid.size
