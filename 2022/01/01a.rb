print File.read("input.txt")
          .split("\n\n")
          .map{ _1.split("\n").map(&:to_i).sum}
          .max