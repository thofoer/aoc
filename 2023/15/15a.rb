print File.read("input.txt").split(?,)
          .sum {|s| s.each_byte.reduce(0){ |a, b| ((a + b) * 17) % 256}}