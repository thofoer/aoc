a = File.readlines("input.txt").map(&:to_i)
b = a.dup

index, step = 0, 0

loop do
    step += 1
    z = a[index] 
    a[index] += 1
    index += z
    break unless (0...a.length).include?(index)
end

puts step

index, step, a = 0, 0, b

loop do
    step += 1
    z = a[index] 
    a[index] += z>=3 ? -1 : 1
    index += z
    break unless (0...a.length).include?(index)
end

puts step