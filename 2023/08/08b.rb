input = File.read("input.txt").split("\n")

@directions = input[0].gsub(?L, ?0).gsub(?R, ?1).split("").map(&:to_i)
@maps = input[2..].map{ |l| l.scan(/[A-Z]{3}/).to_a}.reduce({}){ |h,e| h[e[0]] = e[1..]; h}

def countSteps(start)
    currentPos = start
    index = 0
    steps = 0
    while currentPos[2] != ?Z do
      currentPos = @maps[currentPos][@directions[index % @directions.size]]
      steps += 1
      index += 1
    end
    steps
end

allStarts = @maps.map{|k,_| k}.filter{|p| p[2] == ?A}
steps = allStarts.map{|p| countSteps(p)}

print steps.reduce(&:lcm)