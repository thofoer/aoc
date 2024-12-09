class Integer
    def |(other)
        self.to_s.concat(other.to_s).to_i
    end
end

p File.read("input.txt")
      .scan(/(\d+): (.*)/)
      .map{ |r,n| [r.to_i, n.split().map(&:to_i)]}
      .filter{ |r,n| [:*, :+, :|].repeated_permutation(n.size-1)
                                 .any?{|p| n[1..].each_with_index.inject(n.first){|a,(z,i)| a.send(p[i], z)} == r}}
      .sum(&:first)                       
