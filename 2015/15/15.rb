input = File.readlines("input.txt").map { it.scan(/(-?\d+),.* (-?\d+),.* (-?\d+),.* (-?\d+),.* (-?\d+)/).to_a.flatten.map(&:to_i)}
MAX = 100
 
def addvalue(v)
    v.map do |s|
        sum = s.sum
        (0..(MAX-sum)).to_a.map{|a| [*s, a]}
    end.flatten(1)
end

v = (0..MAX).to_a.map{[it]}
(input.size - 2).times do
    v = addvalue(v)
end

v = v.map{|a| [*a, MAX-a.sum]}

p v.map {|a| (0..3).map {|ing| a.each_with_index.map{|z,i| input[i][ing] * a[i]}.sum}}
   .reject{|q| q.any?{it<0}}
   .map{it.inject(&:*)}
   .max

p v.map {|a| (0..4).map {|ing| a.each_with_index.map{|z,i| input[i][ing] * a[i]}.sum}}
   .reject{|q| q.any?{it<0} || q.last != 500}
   .map{it[..-2].inject(&:*)}
   .max