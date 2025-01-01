input = File.read("input.txt").split("\n\n")

locks, keys = [], []
input.each do |i|
    r = i.split("\n")       
    (r[0][0] == ?# ? locks : keys) << (0..4).to_a.map{|c| r.map{_1[c]}.count(?#) - 1}
end

p locks.product(keys).map{|l,k| l.zip(k).map{_1+_2}}.count{ _1.all?{|v| v <= 5}}