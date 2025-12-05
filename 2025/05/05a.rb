input = File.read("05/input.txt").split("\n\n")
ranges = input[0].lines.map{ it.split(?-).map(&:to_i)}.map{Range.new(*it)}
ing = input[1].lines.map(&:to_i)


p ing.count{ |i| ranges.any?{ |r| r.include?(i)}}