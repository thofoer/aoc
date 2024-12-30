input = File.readlines("input.txt")

scan = []

input.each do | line | 
    line.scan(/(\d+): (.*)$/) do | p, l|
      scan[p.to_i] = l.to_i
    end
end

score = 0

scan.size.times do |i|
    score += i * scan[i] if scan[i] && (i % ((scan[i] - 1) * 2)) == 0        
end

puts score