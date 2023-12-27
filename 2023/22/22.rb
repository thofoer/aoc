require "Matrix"

DZ = Vector[0, 0, 1]

class Brick
  attr_accessor :x1, :y1, :z1, :x2, :y2, :z2
  @@bricks = []
  @@space = Hash.new

  def initialize(coords)
    @x1, @y1, @z1, @x2, @y2, @z2 = *coords
    @@bricks << self
    coords.each { @@space[_1] = self }
  end

  def coords
    coords = Set.new
    if x1 == x2 && y1 == y2
      (z2 - z1 + 1).times{ coords << Vector[x1, y1, z1 + _1]}
    elsif x1 == x2 && z1 == z2
      (y2 - y1 + 1).times{ coords << Vector[x1, y1 + _1, z1]}
    else
      (x2 - x1 + 1).times{ coords << Vector[x1 + _1, y1, z1]}
    end
    coords
  end

  def moveDown!
    coords.each{@@space.delete _1}
    (@z1 -= 1; @z2 -= 1) while @z1 > 1 && coords.none? {@@space[_1 - DZ] }
    coords.each{@@space[_1] = self}
  end

  def supports
    coords.map{ f = @@space[_1 + DZ]; (f || self) != self ? f : nil }.compact.to_set
  end

  def supportedBy
    coords.map{ f = @@space[_1 - DZ]; (f || self) != self ? f : nil }.compact.to_set
  end

  def disintegrationCount
    dis = Set[self]
    check = supports.to_a
    until check.empty?
      b = check.shift
      next if dis.include? b
      next unless b.supportedBy.all? { dis.include? _1 }
      dis << b
      check += b.supports.to_a
    end
    dis.size-1
  end

  def self.all
    @@bricks
  end

  def self.fall!
    @@bricks.sort_by!(&:z1)
    @@bricks.each(&:moveDown!)
  end
end

File.read("input.txt").each_line do
  Brick.new(_1.split(/[,~]/).map(&:to_i))
end

Brick.fall!

part1 = Brick.all.find_all { |brick| brick.supports.all? { |s| s.supportedBy.size > 1}}.size
part2 = Brick.all.sum(&:disintegrationCount)

print "Part 1: #{part1}\n"
print "Part 2: #{part2}\n"
