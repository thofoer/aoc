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

hex = {}

input.map { |seq| seq.inject(Coord.new(0,0,0)){ |a,d| step(a,d)} }.each { hex[_1] ^= true }
    
p hex.values.count(true)