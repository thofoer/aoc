input = File.read("input.txt")
            .split(?,)
            .map{ |e| e.scan(/([^-=]*)(.)(.?)/).flatten }
            .map{ |a,b,c| [a, b, c.to_i] }
def hash(s)
  s.each_byte.reduce(0){|a, b| ((a + b) * 17) % 256}
end

@boxes = []
256.times { @boxes << [] }

def contains?(n)
  @boxes[hash(n)].any? { |a| a[0] == n }
end

def remove(n)
  @boxes[hash(n)].delete_if{ |a| a[0] ==n }
end

def add(n, v)
  @boxes[hash(n)] << [n,v]
end

def replace(n, v)
  x = @boxes[hash(n)].filter{|a| a[0] == n}[0][1] = v
end

input.each do |label, op, value|
  if op == ?-
    remove label
  else
    if contains? label
      replace label, value
    else
      add label, value
    end
  end
end

print @boxes.map.with_index{ |b, i| b.map.with_index{ |a, j| (i+1) * (j+1) * a[1] }.sum }.sum
