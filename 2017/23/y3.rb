b = 65
c = b
b = 100 * b + 100000
c = b + 17000
loop do
    f = 1
    d = 2
    loop do
        e = 2
        loop do 
            f = 0 if (d * e == b)
            e+=1
            break unless e!=b
        end      
        d+=1
        break unless d != b
    end
     (h+=1; puts h) if (f == 0)
     return if (b == c)
    b += 17
end