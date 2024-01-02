input = File.read("2020/13/input.txt").split("\n")
time  = input[0].to_i
dep   = input[1].scan(/\d+/).flatten.map(&:to_i).map{|t| [t, (1 + (time/t)) * t]}.inject(0..Float::INFINITY){ |a,e| e.max < a.max ? e : a }

print dep.min * (dep.max - time)

