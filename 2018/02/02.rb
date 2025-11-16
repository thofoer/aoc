input = File.readlines("input.txt")

OCC = input.map{ it.chars.tally }
def count(c) = OCC.count{ it.has_value? c }

puts count(2) * count(3)


def diff(a, b) = a.empty? ? "" : (a[0] == b[0] ? a[0] : "") + diff(a[1..], b[1..])

puts input.combination(2).lazy.map{|a, b| diff(a, b) }.find{ it.length == input.first.length - 1 }
