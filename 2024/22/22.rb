input = File.readlines("input.txt").map(&:to_i)

def nextnum(n)   
   n = (n <<  6 ^ n) & 0xFFFFFF
   n = (n >>  5 ^ n) & 0xFFFFFF
       (n << 11 ^ n) & 0xFFFFFF
end

def rand(n, times) = (times.times { n = nextnum(n) }; n)

def prices(n)
    price, diff,last = [], [], 0
    
    2000.times do        
        price << v = n % 10
        diff  << v - last
        last = v
        n = nextnum(n)                
    end
    res = {}
    diff[1..].each_cons(4).with_index.each do |seq, ix|
        res[seq] ||= price[ix+4] 
    end
    res.default_proc = proc {0}
    res
end

p input.sum{ rand(_1, 2000) }

maps = input.map{ prices(_1) }
seqs = maps.map(&:keys).inject(&:concat).uniq

p seqs.map{|s| maps.sum{ _1[s]}}.max
