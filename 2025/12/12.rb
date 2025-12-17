p File.readlines("input.txt").map{ it.scan(/(\d+)x(\d+): (.*)/).flatten}
      .reject(&:empty?) 
      .count {|h,w,v| (h.to_i / 3) * (w.to_i / 3) >= v.split.sum(&:to_i)}
            