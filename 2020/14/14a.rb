set, clear, mem =  0, 0, {}

File.read("2020/14/input.txt").each_line do |l|
  if l =~ /mask/
    set   = l[7..].gsub(?X, ?0).to_i(2)
    clear = l[7..].gsub(?X, ?1).to_i(2)
  else
    addr, value = l.scan(/mem\[(\d+)\] = (\d+)/).flatten
    mem[addr.to_i] = value.to_i & clear | set
  end
end
print mem.values.sum
