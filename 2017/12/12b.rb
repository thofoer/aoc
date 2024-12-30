input = File.read("input.txt").split("\n")

$graph = {}
$nodes = Set.new

input.each do | line | 
    line.scan(/(\d+) <-> (.*)$/) do | n, c|
      $graph[n] = c.split(", ").to_set
      $nodes += [n]
    end
end

def visit(node)
    $visited += [node]
    adj = $graph[node]
    adj -= $visited
    adj.each{ |a| visit a }    
end

count = 0
until $nodes.empty?
    count += 1
    $visited = Set.new
    visit($nodes.first)
    $nodes -= $visited
end

print count