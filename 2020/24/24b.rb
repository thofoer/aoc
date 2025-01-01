input = File.readlines("input.txt").map{ _1.scan(/(nw|sw|e|w|ne|se)/).flatten}

Coord = Struct.new(:q, :r, :s)

def step(coord, dir)
    case dir
        when "w"  then coord.q -= 1; coord.s += 1
        when "e"  then coord.q += 1; coord.s -= 1
        when "nw" then coord.r -= 1; coord.s += 1
        when "ne" then coord.r -= 1; coord.q += 1
        when "sw" then coord.r += 1; coord.q -= 1
        when "se" then coord.r += 1; coord.s -= 1
    end
    coord
end

def adjacent(coord)
    [
        step(coord.dup, "w"),
        step(coord.dup, "e"),
        step(coord.dup, "nw"),
        step(coord.dup, "ne"),
        step(coord.dup, "sw"),
        step(coord.dup, "se")
    ]
end

def addAdjacentWhites(hex)
    hex.select{|_,v| v }.keys.each do |black|
        adjacent(black).each do |white|
            hex[white] = false unless hex[white]
        end
    end    
end

hex = {}

input.map { |seq| seq.inject(Coord.new(0,0,0)){ |a,d| step(a,d)} }.each { hex[_1] ^= true }

addAdjacentWhites(hex)

100.times do
    toFlip = hex.select{|_,v| v }.keys.select{|black| [0,3,4,5,6].include?(adjacent(black).count{|ab| hex[ab]})} +
             hex.select{|_,v| !v}.keys.select{|white| adjacent(white).count{|ab| hex[ab]} == 2}
    toFlip.each{hex[_1] ^= true}
    addAdjacentWhites(hex)
end

p hex.values.count(true)
