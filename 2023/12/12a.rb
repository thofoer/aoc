input = File.read("input.txt").split("\n")

def matches(map, springs)
  map.scan(/#+/).map(&:size) == springs
end

def transform(map, size, i)
  res = map.clone
  pattern = ("%0#{size}b" % i).gsub(?0, ?.).gsub(?1, ?#)
  q = size-1
  map.size.times do |p|
    if res[p] == ??
      res[p] = pattern[q]
      q -= 1
    end
  end
  res
end

count = 0
input.map do |l| l.scan(/([\.\?#]+) ([\d,]+)/)
     .each do |row,s|
      runs = s.scan(/\d+/).map(&:to_i)
      m = row.scan(/\?/).count
      (2**m).times do |i|
        count += 1 if matches(transform(row, m, i), runs)
      end
    end
end

puts count
