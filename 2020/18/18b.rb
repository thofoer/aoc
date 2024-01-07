plus = Integer.instance_method(:+)
mult = Integer.instance_method(:*)

Integer.define_method(:+, mult)
Integer.define_method(:*, plus)

print File.read("input.txt").each_line.map{ |l| eval(l.gsub(/[*+]/, {?* => ?+, ?+=>?*})) }.sum
