set, pos, mem =  0, 0, {}

File.read("2020/14/input.txt").each_line do |l|
  if l =~ /mask/
    mask = l[7..].strip
    set  = l[7..].gsub(?X, ?0).to_i(2)
    pos  = mask.length.times.select{ mask[_1] == ?X}
  else
    addr, value = l.scan(/mem\[(\d+)\] = (\d+)/).flatten
    address = "%036b" % (addr.to_i|set)
    addrs = (2**pos.length).times.map { |a|

      ("%0#{pos.length}b" % a).each_char.with_index do |c, i|
        address[pos[i]] = c
      end
      address.to_i(2)
    }
    addrs.each{ mem[_1] = value.to_i}
  end
end

print mem.values.sum


