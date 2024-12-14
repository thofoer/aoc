print File.read("input.txt")
          .split("\n")
          .sum { |z| digits = z.scan(/\d/); (digits[0] + digits[-1]).to_i }
        