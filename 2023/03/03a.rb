numbers = []
symbols = []
File.read("input.txt")
    .each_line
    .with_index do |l, y|
        
        l.enum_for(:scan, /\d+/)
         .map{ [ Regexp.last_match.to_s, Regexp.last_match.begin(0) ]}
         .each do |n, x|           
            numbers << [n.to_i, (x...(x+n.length)).to_a.map{ |p| Complex(p, y)}]
         end         

        l.enum_for(:scan, /[^0-9\.\n]/)
         .map{ Regexp.last_match.begin(0)}
         .each do |x|
            symbols << Complex(x,y)
         end
    end

ADJACENT = [(0+1i), (0-1i), (-1+0i), (+1+0i), (-1-1i), (-1+1i), (+1-1i), (+1+1i)]

sum = numbers.filter {|n, p|    
     p.map{ |a| ADJACENT.map{|b| a+b}}.flatten.any? {|n3| symbols.include? n3}
}.sum{|k, _| k}

print sum