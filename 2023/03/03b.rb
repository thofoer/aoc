ADJACENT = [(0+1i), (0-1i), (-1+0i), (+1+0i), (-1-1i), (-1+1i), (+1-1i), (+1+1i)]

numbers = []
gears = []

File.read("input.txt")
    .each_line
    .with_index do |l, y|
        
        l.enum_for(:scan, /\d+/)
         .map{ [ Regexp.last_match.to_s, Regexp.last_match.begin(0) ]}
         .each do |n, x|           
            numbers << [n.to_i, (x...(x+n.length)).to_a.map{ |p| Complex(p, y)}.map{|a| ADJACENT.map{|b| a+b}}.flatten.to_set]
         end         

        l.enum_for(:scan, /\*/)
         .map{ Regexp.last_match.begin(0)}
         .each do |x|
            gears << Complex(x,y)
         end
    end

print gears.map{ |gearpos| numbers.filter{ |n, p| p.include? gearpos}}
           .filter{ |r| r.size == 2}
           .map{ |r| r[0][0] * r[1][0]}
           .sum
