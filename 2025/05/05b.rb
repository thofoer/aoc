class Range
  def subtract(other)
    return [] if (other.begin <= self.begin && other.max >= self.max)
    return [self] if other.begin > self.end || other.end < self.begin
    res = []
    res << (self.begin..other.begin-1) if self.begin < other.begin
    res << (other.max+1..self.max) if other.max < self.max
    res
  end
  alias_method :-, :subtract
end

input = File.read("05/input.txt").split("\n\n")
ranges = input[0].lines.map{ it.split(?-).map(&:to_i)}.map{Range.new(*it)}

s = []

ranges.each do |r|
  n = s.inject([r]){|a,i| a.map{it-i}.flatten}
  n.each{ s << it }
end

puts s.sum(&:size)