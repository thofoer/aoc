require 'pairing_heap'

heap = PairingHeap::MinPriorityQueue.new

heap.push "a", 1
heap.push "b", 10
heap.push "d", 10
heap.push "d", 15
heap.push "e", 30

until heap.empty? do
    p heap.pop_with_priority
end
