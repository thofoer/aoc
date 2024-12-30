input = File.readlines("input.txt", chomp: true).map(&:split)

p input.map(&:tally).count{ _1.values.all?(1) }
p input.map{|p| p.map{|l| l.split("").sort.join}}.map(&:tally).count{ _1.values.all?(1) }