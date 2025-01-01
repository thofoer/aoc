$input = File.read("input.txt").split(",")

$a = ('a'..'p').to_a.join
LEN = $a.size

def dance
    $input.each do | c |
        cmd, p, q = c.scan(/(.)(\w+)(?:\/(\w+))?/).flatten
    
        case cmd
        when 's'
            n = p.to_i
            $a = $a[(LEN-n..LEN)] + $a[(0..LEN-n-1)]
        when 'x'
            n = p.to_i
            m = q.to_i
            $a[n], $a[m] = $a[m], $a[n]
        when 'p'        
            n = $a.index(p)
            m = $a.index(q)
            $a[n], $a[m] = $a[m], $a[n]
        end
    end
end

hist = Hash.new
round = 0
until hist.include? $a
   hist[$a] = round
   round += 1
   dance
   puts $a if round == 1   
end
cycle = round - hist[$a]

remainder = (1000000000 - hist[$a]) % cycle

remainder.times do 
    dance
end

puts $a