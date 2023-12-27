input = File.read("input.txt").split("\n")

directions = input[0].gsub(?L, ?0).gsub(?R, ?1).split("").map(&:to_i)
maps = input[2..].map{ |l| l.scan(/[A-Z]{3}/).to_a}.reduce({}){ |h, e| h[e[0]] = e[1..]; h}

currentPos = "AAA"
len = directions.size
index = 0
steps = 0

while currentPos != "ZZZ" do
  currentPos = maps[currentPos][directions[index % len]]
  steps += 1
  index += 1
end

print steps