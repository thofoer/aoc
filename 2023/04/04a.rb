print File.read("input.txt")
    .each_line
    .map{ |l| [l[10..39].split.map(&:to_i), l[42..].split.map(&:to_i)] }
    .map{ |a, b| a.intersection(b).count}
    .filter{ |s| s > 0}
    .sum{ |s| 1 << (s-1)}
 