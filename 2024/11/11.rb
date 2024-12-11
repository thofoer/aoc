input = File.read("input.txt").split.map{|z| [z, 1]}.to_h

def blink(a, times)
  times.times do
    b = Hash.new(0)
    a.entries.each do |n, c|
    if n == ?0
      b[?1] += c
    elsif n.size.even?
      b[n[0..(n.length/2-1)]] += c
      b[n[(n.length/2)..].to_i.to_s] += c
    else
      b[(n.to_i * 2024).to_s] += c
    end
  end
  a = b
  end
  a.values.sum
end

puts "Part 1: #{blink(input, 25)}", "Part 2: #{blink(input, 75)}"
