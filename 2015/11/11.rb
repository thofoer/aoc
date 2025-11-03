s = File.read("input.txt")

def inc(s)
    buf = s.unpack("c*")
    c = 1    
    (buf.length - 1).downto(0) do |i|
        buf[i] = buf[i] + c
        c = 0
        if  buf[i] > 122 
            buf[i] = 97
            c = 1            
        end        
    end
    buf.pack("c*")
end

def good?(s)
    return false if s.bytes.each_cons(3).none?{ |a,b,c| c == b + 1 && b == a + 1}
    return false if /i|o|l/.match?(s)
    /.*(?<a>.)\k<a>.*(?<b>.)\k<b>.*/.match?(s)
end

2.times do
    s = inc(s)
    until good?(s)
        s = inc(s)
    end
    puts s
end
