input = File.readlines("input.txt").map(&:to_i)

def nextnum(n)   
   n = (n <<  6 ^ n) & 0xFFFFFF
   n = (n >>  5 ^ n) & 0xFFFFFF
       (n << 11 ^ n) & 0xFFFFFF
end

def rand(n, times)    
    times.times { n = nextnum(n) }        
    n
end
s=Time.now
p input.sum{ rand(_1, 2000)}
p Time.now - s