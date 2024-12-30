input = File.read("input.txt")

q, r, dist, max = 0, 0, 0, 0

input.split(",").each do |d|
  case d
  when 'n'  then r -= 1
  when 'ne' then q -= 1
  when 'se' then q -= 1; r += 1
  when 's'  then r += 1
  when 'sw' then q += 1
  when 'nw' then r -= 1; q += 1
  end
  dist = (q.abs + r.abs + (q + r).abs) / 2

  max = [max, dist].max
end

puts "final dist: #{dist}"
puts "max dist: #{max}"

# https://www.redblobgames.com/grids/hexagons/