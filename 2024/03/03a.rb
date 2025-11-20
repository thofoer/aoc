p File.read("input.txt")
      .scan(/mul\((\d+),(\d+)\)/)
      .sum{ it.map(&:to_i).inject(:*) }