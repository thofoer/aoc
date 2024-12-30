input = File.readlines("input.txt")

class Item    
    attr_accessor :name, :weight, :links, :parent
    
    def initialize(name, weight, links)
        @name, @weight, @links = name, weight, links
        @parent = nil
    end

    def totalWeight        
        weight + (links ? links.sum{ |i| i.totalWeight } : 0)
    end
end

items = {}

input.each do |line|
    line.scan(/(.+) \((.+)\)(?: -> (.+))?/) do |name, weight, links|
        items[name] = Item.new(name, weight.to_i, links&.split(", "))
    end
end

items.each do |name, entry| 
    if entry.links
        entry.links.each do |child|
            items[child].parent = entry.name
        end
        entry.links = entry.links.map{ items[_1] }
    end
end


root = items.values.select{ |item| item.parent == nil }.first

currWeight = root.weight

node = root
diff = 0

loop do
    balance = node.links.map(&:totalWeight)
    
    if balance.uniq.count == 1
      break
    else
        stats = balance.tally

        p stats
        gets
        deviant  = stats.select{ |_, v| v == 1 }.first[0]
        standard = stats.select{ |_, v| v != 1 }.first[0]
        devItem = node.links[balance.index(deviant)]
        stdItem = node.links[balance.index(standard)]

        diff = devItem.totalWeight - stdItem.totalWeight

        node = devItem
        currWeight = node.weight
    end
end

puts root.name
puts currWeight - diff