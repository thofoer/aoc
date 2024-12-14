input = File.read("input2.txt").split("\n")

@graph = Hash.new
@nodes = []

input.each do | line | 
    line.scan(/(\d+) <-> (.*)$/) do | n, c|
      @graph[n] = c.split(", ")
      @nodes += [n]
    end
end


def visit(node)
    @visited += [node] unless @visited.include? node
    adj = @graph[node]
    adj -= @visited
    adj.each do |a| 
        visit a 
    end
end

count = 0
until @nodes.empty?
    count += 1
    @visited = []
    visit(@nodes[0])
    @nodes -= @visited
end


print count
