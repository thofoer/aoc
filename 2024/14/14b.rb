robots = File.read("input.txt")
             .scan(/p=(\d+),(\d+) v=(-?\d+),(-?\d+)/)
             .map{ |px, py, vx, vy| [Complex(px.to_i, py.to_i), Complex(vx.to_i, vy.to_i)]}

W = 101
H = 103

def dump(p)
    s = Set.new(p)
    (0...H).each do |y|
        (0...W).each do |x|
            print s.include?(Complex(x,y)) ? ?X : ?.
        end
        puts
    end
end

z=0
loop do
   z+=1   
   pos = robots.map{|p,v| z*v + p }
               .map{|c| Complex(c.real % W, c.imag % H)}                  
   
   if pos.size==500
        dump(pos)
        p z
        break
   end
end