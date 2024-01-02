input = File.read("2020/13/input.txt").split("\n")
bus   = input[1].gsub(?x, ?0).scan(/\d+/).flatten.map(&:to_i)

time, wait = 1, 1

bus.size.times do |t|
  next if bus[t] == 0

  loop do
    if (time + t) % bus[t] == 0
      wait *= bus[t]
      break
    end
    time += wait
  end
end

print time
