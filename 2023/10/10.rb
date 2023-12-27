@grid = File.read("input.txt").split("\n").map{|l| l.split("")}

start = @grid.map.with_index{ |r,i| r.include?(?S) ? Complex(r.index(?S), i) : nil}.compact.first

@dirs = [ n = (0-1i), e = (1+0i), s = (0+1i), w = (-1+0i)]

vert1 = %w[| 7 F S]
vert2 = %w[| J L S]
hori1 = %w[- J 7 S]
hori2 = %w[- F L S]

@turns = {
    ?S => {n => vert1, s => vert2, e => hori1, w => hori2},
    ?| => {n => vert1, s => vert2},
    ?- => {e => hori1, w => hori2},
    ?F => {e => hori1, s => vert2},
    ?7 => {w => hori2, s => vert2},
    ?J => {n => vert1, w => hori2},
    ?L => {n => vert1, e => hori1}
}

def tile(pos)    
    @grid[pos.imag][pos.real]
end

def adjacent(lastPos, pos)
    here = tile(pos)
    @dirs.map do |dir|
        nextPos = pos + dir
        there = tile(nextPos)        
        found = @turns[here][dir]
        return nextPos unless found.nil? || !found.include?(there) || nextPos == lastPos
    end
end

path = [start]
lastPos, nextPos = start, adjacent(start, start)

until nextPos == start
    path << nextPos    
    lastPos, nextPos = nextPos, adjacent(lastPos, nextPos)    
end

puts "Part 1: #{path.size >> 1}"


orientation = path[0]-path[1]
path.reverse! if orientation.imag < 0 || orientation.real < 0

area = path.each_cons(2).map{ |a,b|     
     (b.real - a.real) * (b.imag + a.imag) >> 1  # https://de.wikipedia.org/wiki/Gau%C3%9Fsche_Trapezformel
}.sum - (path.size / 2) + 1                      # https://de.wikipedia.org/wiki/Satz_von_Pick

puts "Part 2: #{area.to_i}"
