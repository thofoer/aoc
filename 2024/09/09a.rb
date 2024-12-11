Chunk = Struct.new(:size, :id, :alloc?)

disk = File.read("input.txt")
           .chars
           .map(&:to_i)
           .each_with_index
           .map{ |size, index| Chunk.new(size, index/2, index.even?)}
index = 0
checksum = 0

until disk.empty?
  current = disk.shift

  if current.alloc?
     current.size.times{|n| checksum += (n+index) * current.id}
     index += current.size
  else
     last = disk.pop
     last = disk.pop unless last.alloc?
     if last.size > current.size
       current.size.times{ |n| checksum += (n+index) * last.id}
       index += current.size
       last.size -= current.size
       disk.push last
     else
       last.size.times{ |n| checksum += (n+index) * last.id}
       index += last.size
       current.size -= last.size
       disk.unshift current
     end
   end
end

p checksum
