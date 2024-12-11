disk = []
i = 0

File.read("input.txt")
           .chars
           .map(&:to_i)
           .each_slice(2) do |a,f|
              a.times { disk << i }
              f&.times { disk << nil }
              i+=1
           end
def dump(disk)
  disk.map{ |c| c.nil? ? "." : c }.join
end
s = Time.now

#p dump(disk)

min = 0
max = disk.size-1

loop do

  ae = max

  ae -= 1 while disk[ae].nil? && ae > 0
  aa = ae
  id = disk[aa]
  aa -= 1 while disk[aa-1]==id  && aa > 0
  as = ae-aa+1

  # p aa, ae
  # p disk[aa..ae]
  fa = 0
  fe = 0
  fs = 0

  fa = min
  loop do

    fa += 1 until disk[fa].nil? || fa > max
    fe = fa
    fe += 1 while disk[fe+1].nil? && fe < max
    fs = fe-fa+1
    break if fs >= as || fa >= max
    fa += 1 while disk[fa].nil? && fa < max
  end

  if fa < max && fa < aa
    as.times do |i|
      disk[fa+i] = disk[aa+i]
      disk[aa+i] = nil
    end
  else
    max = aa-1
  end

  #puts "#{fe} #{aa}"

  # p dump(disk)
  #gets
  break if max <= 0

  min += 1 until disk[min+1].nil?
end

p disk.each_with_index.map{ |c, i| c.nil? ? 0 : c*i}.sum
# p fa, fe
# p disk[fa..fe]

#2333133121414131402
# 00...111...2...333.44.5555.6666.777.888899
# 0099.111...2...333.44.5555.6666.777.8888..
# 0099.1117772...333.44.5555.6666.....8888..
# 0099.111777244.333....5555.6666.....8888..
# 00992111777.44.333....5555.6666.....8888..

e = Time.now
p e-s