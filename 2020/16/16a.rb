input = File.read("input.txt").split("\n\n")

checkers = input.first.split("\n").map do |l|
    l = l.scan(/(\d+)\-(\d+) or (\d+)\-(\d+)/).flatten.map(&:to_i)
    lambda{|v| v.between?(l[0], l[1]) || v.between?(l[2], l[3]) }
end

print input.last[16..].split(/,|\n/).map(&:to_i).select{|v| checkers.none?{|c| c.call(v)}}.sum


class Integer
    @@plus = self.instance_method(:+)
    @@mult = self.instance_method(:*)

    def +(o)
        @@mult.bind(self).call(o)
    end
    def *(o)
        @@plus.bind(self).call(o)
    end
end

puts
puts 9+22
puts 9*22
