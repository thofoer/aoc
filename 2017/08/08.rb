input = File.readlines("input.txt")
varnames = input.map{ |line| line.match(/([a-z]+) / )[1] }.uniq

bind = binding

varnames.each do |name|
  eval("#{name}=0", bind)
end
names = varnames.join(?,)

totalmax, max = 0, 0

input.each do |line|
  eval(line.sub(" inc ", " += ").sub(" dec ", " -= "), bind)
  max = eval("[#{names}].max", bind)
  totalmax = [max, totalmax].max
end

puts max
puts totalmax