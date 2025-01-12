input = File.read("input.txt")

p input.count("(") - input.count(")")

p (1..input.size).find{ input[0..it].count(")") == input[0..it].count("(") + 1 } + 1