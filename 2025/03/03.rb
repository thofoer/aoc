input = File.readlines("03/input.txt", chomp: true)

def solve(source, digits, result="")
  return result if result.length == digits

  chunk = source[..result.length - digits]
  i = chunk.index(chunk.chars.max)
  solve(source[i+1..], digits, result+source[i])
end

puts input.sum{ solve(it, 2).to_i }
puts input.sum{ solve(it, 12).to_i }