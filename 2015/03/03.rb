input = File.read("input.txt").split("")

pos = 0+0i
visited = Set.new([0+0i])

STEP = { ?< => -1+0i, ?^ => 0-1i, ?> => 1+0i, ?v => 0+1i}

input.each do |c|
    visited << pos += STEP[c]   
end

p visited.size


pos1 = 0+0i
pos2 = 0+0i
visited = Set.new([0+0i])

input.each_slice(2) do |s,r|
    visited << pos1 += STEP[s]
    visited << pos2 += STEP[r]
end

p visited.size