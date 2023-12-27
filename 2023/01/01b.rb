input = File.read("input.txt").split("\n")

digits = %w[one two three four five six seven eight nine]
input.each { |s| digits.each_with_index{ |d, i| s.gsub!(d, "#{d}#{i+1}#{d}")}}

print input.map { |z| (z.scan(/\d/)[0] + z.scan(/\d/)[-1]).to_i }.sum
