grid = File.read("input.txt").split("\n")

W, H   = grid.size, grid[0].size
map    = Set.new
start  = nil
target = nil
DIRS   = [1+0i, 0-1i, -1+0i, 0+1i]
dir    = 0

W.times do |y|
  H.times do |x|
    p = Complex(x,y)
    value = grid[y][x]
    map << p if value == ?#
    start  = p if value == ?S
    target = p if value == ?E
  end
end

def dump(map, path)
    
    (0...H).each do |y|
        (0...W).each do |x|
            c = Complex(x,y)
            print map.include?(c) ?  ?# : path.nodes.include?(c) ? "@" : "."
        end
        puts
    end    
end

class Path
    attr_accessor :nodes, :heading, :score

    def initialize(nodes=[], heading=0, score=0)
        @nodes   = nodes
        @heading = heading
        @score   = score
    end

    def way?(map, dir)
        f = nodes.last + DIRS[(heading+dir)%4]
        !map.include?(f) && !nodes.include?(f)
    end
  
    def step
        Path.new(nodes.dup << nodes.last+DIRS[heading], heading, score+1)
    end

    def turn(rot)
        d = (heading+rot)%4
        Path.new(nodes.dup << nodes.last+DIRS[d], d, score+1001)
    end

    def target?(pos)
        nodes.last == pos
    end

    def <=>(other)
        if nodes.length == other.nodes.length
            other.score<=>score
        else
            nodes.length<=>other.nodes.length
        end
        
    end

    def to_s
        "nodes=#{nodes}, heading=#{heading}, score=#{score}"
    end
end

track = [Path.new([start])]

w = Hash.new(Float::INFINITY)

best = Float::INFINITY
s=Time.now
routes = []

until track.empty?
    t = track.pop
    
    next if t.score > best
    
    if t.target?(target)
        # dump(map, t)
        puts "target= #{t.score}"
        #gets
        routes=[] if t.score < best
        routes << t.nodes
        best = [best, t.score].min
        next
    end
    
    next if w[[t.nodes.last, t.heading]] < t.score
    
    w[[t.nodes.last, t.heading]]=t.score

    track << t.step     if t.way?(map, 0)
    track << t.turn(1)  if t.way?(map, 1)
    track << t.turn(-1) if t.way?(map, -1)
    #dump(map, t)
    #gets
    track.sort!
end

p best
p routes.map(&:to_set).inject(&:merge).size
e=Time.now
p e-s

