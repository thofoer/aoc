input = File.readlines("input.txt")

$graph = {}

input.each do | line | 
    line.scan(/(\d+) <-> (.*)$/) do |n, c|
      $graph[n] = c.split(", ").to_set
    end
end

$visited = Set.new
def visit(node)
    $visited += [node]
    adj = $graph[node]
    adj -= $visited
    adj.each { |a| visit a }    
end

visit("0")

print $visited.size