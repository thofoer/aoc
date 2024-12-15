map, dirs = File.read("input.txt").split("\n\n")

dirs = dirs.gsub("\n", "").chars
grid = map.split("\n")

W, H  = grid.size, grid[0].size
map   = {}
robot = nil

W.times do |y|
  H.times do |x|
    pos = Complex(x,y)
    value = grid[y][x]
    map[pos] = value if value == ?# || value == ?O    
    robot = pos if value == ?@
  end
end

DIR = { ?< => -1+0i, ?^ => 0-1i, ?> => 1+0i, ?v => 0+1i }

def dump(map, pos)
    (0...H).each do |y|
        (0...W).each do |x|
            c = Complex(x,y)
            print map[c] ?  map[c] : c==pos ? "@" : "."
        end
        puts
    end
    puts "-----------------------------"
end
dump(map, robot)


dirs.each do |dir|    
    delta = DIR[dir]
    n = delta + robot    
    if map[n] == nil 
        robot = n        
    elsif map[n] == ?O
        b = (1..).take_while{ |d| map[delta*d + robot] == ?O }
        unless map[(b.last+1)*delta + robot]
            map[(b.last+1)*delta + robot] = ?O
            map[n] = nil
            robot = n            
        end            
    end
  #  dump(map, robot)    
  #  gets
end

dump(map, robot)    
p map.filter{|k,v| v==?O}.keys.sum{|p| 100*p.imag + p.real }
