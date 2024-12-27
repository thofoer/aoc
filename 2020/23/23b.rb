a = File.read("input.txt").split("").map(&:to_i)
MAX = 1000000

Node = Struct.new(:label, :next)
sss = Time.now
lookup = {}

curr = prev = Node.new(a.first, nil)
lookup[a.first] = curr
a[1..].each do |l|  
  prev.next = n = Node.new(l, nil)
  lookup[l] = n
  prev = n
end

(10..MAX).each do |l|
  prev.next = n = Node.new(l, nil)
  lookup[l] = n
  prev = n
end

prev.next = curr

10000000.times do |zz|
  #print zz/1000000 if zz%1000000 == 0
  toMoveFirst = curr.next
  toMoveSecond = toMoveFirst.next
  toMoveLast = toMoveSecond.next

  curr.next = toMoveLast.next

  dest = curr.label - 1
  dest -= 1 if dest == 0
  destNode = nil

  until destNode && destNode != toMoveFirst && destNode != toMoveSecond && destNode != toMoveLast do    
    destNode = lookup[dest % (MAX+1) ]
    dest -= 1
  end

  afterDest = destNode.next
  destNode.next = toMoveFirst
  toMoveLast.next = afterDest

  curr = curr.next
end
#puts

one = lookup[1]
p one.next.label * one.next.next.label

p Time.now - sss