map, dirs = File.read("input.txt").split("\n\n")

dirs = dirs.gsub("\n", "").chars
grid  = map.split("\n")

map = {}
H, W  = grid.size, grid[0].size
robot  = nil

H.times do |y|
  W.times do |x|
    posl, posr = Complex(2*x,y), Complex(2*x+1,y)
    case grid[y][x]
    when ?# 
        map[posl]=?#
        map[posr]=?#
    when ?O
        map[posl]=?[
        map[posr]=?]
    when ?@
        robot = posl
    end    
  end
end

DIR = { ?< => -1+0i, ?^ => 0-1i, ?> => 1+0i, ?v => 0+1i }
@zz=0

def dump(map, pos)
    puts @zz
    @zz+=1
    (0...H).each do |y|
        (0...2*W).each do |x|
            c = Complex(x,y)
            print map[c] ?  map[c] : c==pos ? "@" : "."
        end
        puts
    end    
end

dirs.each do |dir|    
    delta = DIR[dir]
    n = delta + robot    
    if map[n] == nil 
        robot = n                     
    elsif dir == ?< || dir == ?>
        b = (1..).take_while{ |d| [?[,?]].include?(map[delta*d + robot]) }.reverse << 0        
        
        unless map[(b.first+1)*delta + robot]
            b.each{|i| map[(i+1)*delta + robot] = map[(i)*delta + robot]}
            robot = n            
        end
    elsif map[n] != ?#
        boxes = [Set.new([n, map[n] == ?] ? n-1 : n+1])]        
        searching = true
        while searching do            
            line = boxes.last            
            newLine = Set.new
            line.each do |c| 
                check = c+delta
                newLine << check << (map[check] == ?] ? check-1 : check+1) if map[check] == ?] || map[check] == ?[
            end            
            boxes << newLine           
            searching = false if newLine.empty?                                            
        end                        
        if boxes.all?{ _1.all?{|c| map[c+delta] != ?#}}
            boxes.reverse.each do |c|
                c.each{|p| map[p+delta] = map[p]; map[p] = nil}
                robot = n
            end
        end        
    end  
end

p map.filter{|k,v| v==?[}.keys.sum{|p| 100*p.imag + p.real }
