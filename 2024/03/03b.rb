p File.read("input.txt")
      .gsub(/\n/,"")
      .gsub(/don't\(\).*?(do\(\)|$)/, "")
      .scan(/mul\((\d+),(\d+)\)/)
      .sum{ it.map(&:to_i).inject(:*) }
