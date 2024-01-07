Integer.define_method(:-, Integer.instance_method(:*))

print File.read("input.txt").each_line.map{ |l| eval(l.gsub(?*, ?-)) }.sum
