input = File.read("input.txt", chomp: true).split("\n\n")
rules = input[0].split("\n").map { it.scan(/(\w+) => (\w+)/)}.flatten(1).map{|k,v| [v.reverse, k.reverse]}.to_h
target = input[1].reverse
regex = Regexp.new rules.keys.join("|")

z = 0
while target != ?e
    range = target.match(regex).offset(0)
    target[range.first...range.last] = rules[$&]
    z = z + 1    
end
print z