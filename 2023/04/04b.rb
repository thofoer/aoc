input = File.read("input.txt")
    .each_line
    .map{ |l| [l[10..39].split.map(&:to_i), l[42..].split.map(&:to_i)] }
    .map{ |a,b| a.intersection(b).count}

count = [1] * input.size

input.size.times do |i|
  input[i].times do |j|
    count[i+j+1] += count[i]
  end
end

print count.sum