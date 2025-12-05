input = File.read("02/input.txt").scan(/(\d+)-(\d+)/)

def invalid?(s) = (1..s.length+1).any? {|m| (1..s.length/2).any?{ s == s[0...it] * m}}

def invalids(a, b) = a.upto(b).filter{invalid?(it)}.sum(&:to_i)


p input.sum{ |a, b| invalids(a, b) }
