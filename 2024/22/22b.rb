input = File.readlines("input.txt").map(&:to_i)

def nextnum(n)   
   n = (n <<  6 ^ n) & 0xFFFFFF
   n = (n >>  5 ^ n) & 0xFFFFFF
       (n << 11 ^ n) & 0xFFFFFF
end

def prices(n)
    price, diff = [], []
    last = 0
    2000.times do        
        price << n % 10
        diff  << n % 10 - last
        last = n % 10
        n = nextnum(n)                
    end
    res = {}
    diff[1..].each_cons(4).with_index.each do |seq, ix|
        res[seq] = price[ix+4] unless res[seq]
    end
    res
end

s=Time.now

maps = input.map{ prices(_1) }

seqs = maps.map(&:keys).inject(&:concat).uniq

p seqs.map{|s| maps.sum{|m| m[s] ? m[s] : 0 }}.max

p Time.now - s