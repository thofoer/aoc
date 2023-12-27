input = File.read("input.txt").split("\n\n")

class Range
   def intersection(other)
      new_min = self.cover?(other.min) ? other.min : other.cover?(min) ? min : nil
      new_max = self.cover?(other.max) ? other.max : other.cover?(max) ? max : nil

      new_min && new_max ? new_min..new_max : nil
   end
   alias_method :&, :intersection
end

seeds = input[0][6..].split.map(&:to_i).each_slice(2).map{ |a,b| (a..(a + b - 1))}

maps = input[1..]
         .map{ |l| l.split("\n")}
         .map{ |a| a[1..].map(&:split).map{ |i| i.map(&:to_i)}
                                      .map{ |t,s,l| [(s..(s + l - 1)), t-s]}
                         .sort{|a, b| a[0].begin <=> b[0].begin }}

def processRange(range, map)
   sects = map.map{ |m| [m[0] & range, m[1]] }
                 .delete_if { |m| m[0].nil? }
  
   sects.push [range, 0] if sects.empty?
   sects.map{ |m| ((m[0].begin + m[1])..(m[0].max + m[1]) )}
end

def process(range, map)
   range.map{|r| processRange(r, map)}.flatten
end

a = seeds
7.times do |i|
   a = process(a, maps[i])
end

print a.map(&:min).min