input = File.read("input.txt").scan(/(\d+)x(\d+)x(\d+)/).map{ it.map(&:to_i).sort }

p input.sum{ |l, w, h| 3*l*w + 2*l*h + 2*w*h }

p input.sum{ |l, w, h| 2*(l+w) + l*h*w }
