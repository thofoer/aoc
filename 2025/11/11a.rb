TREE = File.readlines("input.txt").map{ it.scan(/(...): (.*)/)}
           .flatten(1)
           .map{|node, neighbours| [node, neighbours.split]}
           .to_h

def solve(node, target)
    return 1 if node == target
    n = TREE[node]
    n.nil? ? 0 : n.map{solve(it, target)}.compact.sum
end

p solve("you", "out")
p solve("svr", "fft")