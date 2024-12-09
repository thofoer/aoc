p File.read("input.txt")
      .scan(/mul\((\d+),(\d+)\)/)
      .map{ |l| l.map(&:to_i).inject(:*) }
      .sum