#a=729
#a=25358015
a= (7<<3) + (7<<0) #+ (7<<3)
b=0
c=0

#prg = [0,1,5,4,3,0]
@prg=[2,4,1,1,7,5,0,3,4,7,1,6,5,5,3,0]
i=0

def func(a)
    b=0
    c=0
    i=0
    out = []
    loop do
        op = @prg[i]
        v = @prg[i+1]
        combo = [0, 1, 2, 3, a, b, c][v]
        case op
        when 0
            a = a / 2 ** combo
            i+=2
        when 1
            b ^= v
            i+=2
        when 2
            b = combo % 8
            i+=2
        when 3
            i = (a!=0 ? v : i+2)
        when 4
            b = b ^c
            i+=2
        when 5
            out << combo % 8
            i+=2
        when 6
            b = a / 2 ** combo
            i+=2
        when 7
            c = a / 2 ** combo
            i+=2
        end
        return out if i>=@prg.size
    end
end

l = nil

def search(start=0, rightHalf)
    offset, range = rightHalf ? [24, 8..] : [0, 0..]
    
    result = Float::INFINITY

    (0..7).to_a.repeated_permutation(8).each do |digits| 
        a = digits.map.with_index{|d,i| d << ((3*i)+offset) }.inject(&:|) | start
    
        #a = b15 << 45 | b14 << 42 | b13 << 39 | b12 << 36 | b11 << 33 | b10 << 30 | b9 << 27 | b8 << 24

        r = func(a)
    
        if r[range] == @prg[range]
            puts a
            p r
            result = [result, a].min
        end
    end 
    result
end

p search(search(0, true), false)


#start = Float::INFINITY

#(0..7).to_a.repeated_permutation(8).each do |b8, b9, b10, b11, b12, b13, b14, b15| 
#    a = b15 << 45 | b14 << 42 | b13 << 39 | b12 << 36 | b11 << 33 | b10 << 30 | b9 << 27 | b8 << 24
#
#    r = func(a)
#    
#    if r[8..] == @prg[8..]
#        puts a
#        p r
#        start = [start, a].min
#    end
#end
#start = 247838990663680
#p start
#
#p "start"
#
#(0..7).to_a.repeated_permutation(8).each do |b0, b1, b2, b3, b4, b5, b6, b7| 
#    a = b7 << 21 | b6 << 18 | b5 << 15 | b4 << 12 | b3 << 9 | b2 << 6 | b1 << 3 | b0 | start
#
 #   r = func(a)
 #   
 #   if r == @prg
 #       puts a
 #       p r    
 #   end
#end
