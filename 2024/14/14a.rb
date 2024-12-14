robots = File.read("input.txt")
             .scan(/p=(\d+),(\d+) v=(-?\d+),(-?\d+)/)
             .map{ |px, py, vx, vy| [Complex(px.to_i, py.to_i), Complex(vx.to_i, vy.to_i)]}

W = 101
H = 103          

pos = robots.map{|p,v| 100*v + p }
            .map{|c| Complex(c.real % W, c.imag % H)}      
    
qx1 = (0...W/2)
qx2 = (W/2+1...W)
qy1 = (0...H/2)
qy2 = (H/2+1...H)

quadrants = [[qx1, qy1], [qx2, qy1], [qx1, qy2], [qx2, qy2]]
p quadrants.map{|q| pos.count{|p| q.first.include?(p.real) && q.last.include?(p.imag)}}
           .inject(&:*)
