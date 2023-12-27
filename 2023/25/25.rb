edges = Set.new
nodes = []
File.read("input.txt").each_line(chomp:true) do |l|
  node = l[0..2]
  nodes << node
  l[5..].split(" ").each do |m|
    edges << [node, m]
    nodes << m
  end
end
nodes.uniq!

def makeGraph(n, e)
  graph = n.map{ |q| [q, Set.new] }.to_h
  e.each do |a,b|
    graph[a] << b
    graph[b] << a
  end
  graph
end

def shortestPath(a, b, g)
  queue = [[a]]
  visited = Set.new
  until queue.empty?
    p = queue.shift
    n = p.last
    return p if n == b
    visited << n
    g[n].reject{ visited.include?(_1)}.each { queue << (p + [_1])}
  end
  nil
end

def removeEdges(path, g)
  path.each_cons(2) do |a,b|
    g[a].delete b
    g[b].delete a
  end
  g
end

pivot = nodes.first
partition1 = [pivot]
partition2 = []

nodes[1..].each do |node|
  g = makeGraph(nodes, edges)

  3.times do
    path = shortestPath(pivot, node, g)
    g = removeEdges(path, g)
  end

  unreachable = shortestPath(pivot, node, g).nil?
  (unreachable ? partition2 : partition1) << node
end

puts partition1.size * partition2.size