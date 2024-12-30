input = File.read("input.txt")

garbage, skip = false, false

sum, depth, count = 0, 0, 0

input.each_char do |c|
  
  (skip = false; next) if skip
  
  case c
  when ?!
    skip = true
  when ?<
    count += 1 if garbage
    garbage = true
  when ?>
    garbage = false
  when ?{
    if garbage
      count += 1      
    else
      depth += 1
      sum += depth
    end
  when ?}
    if garbage
      count += 1
    else
      depth -= 1
    end
  else
    count += 1 if c != ?, || garbage
  end
end

puts "Sum: #{sum}"
puts "Garbage count: #{count}"