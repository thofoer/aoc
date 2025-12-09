class Box
  attr_reader :x, :y, :z

  def initialize(x, y, z)
    @x, @y, @z = x, y, z
  end

  def dist(other) = (self.x - other.x)**2 + (self.y - other.y)**2 + (self.z - other.z)**2
end

boxes = File.readlines("08/input.txt").map{ it.split(?,).map(&:to_i)}.map{Box.new(*it)}

order = (0...boxes.size)
          .to_a
          .combination(2)
          .map{|i,j| [i,j,boxes[i].dist(boxes[j])]}
          .sort_by{ it.last }
          .map{Set.new(it[0..1])}
          .lazy

def merge(circuits)
  changed = true
  while changed
    changed = false
    res = []
    circuits.each do |set|
      box = res.find{|a| set.any?{|b| a.include?(b)}}
      if box
        box.merge(set)
        changed = true
      else
        res << set
      end
    end
    circuits = res
  end
  res
end

puts merge(order.take(1000)).map(&:size).sort.reverse[0..2].reduce(&:*)