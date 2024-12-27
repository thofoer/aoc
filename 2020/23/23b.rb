a = File.read("input.txt").split("").map(&:to_i)
MAX = 1000000

Node = Struct.new(:label, :next)
sss = Time.now
lookup = {}

curr = prev = Node.new(a.first, nil)
lookup[a.first] = curr

(1...MAX).each do |i|
  l = i < 9 ? a[i] : i+1
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