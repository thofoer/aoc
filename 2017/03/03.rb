N = File.read("input.txt", chomp: true).to_i

def coords(index)
    r = Math.sqrt(index).to_i
    r -= 1 if r.even?

    a = index - r**2
    x = (r-1) / 2
    y = x

    if a.between?(1, r+1)         
        x = x + 1
        y = y - a + 1
    elsif a.between?(r+2, 2*r+2)        
        y = y - r
        x = x - a + r +2
    elsif a.between?(2*r+3, 3*r+3)        
        x = x - r
        y = y + a - 3*r -2
    elsif a.between?(3*r+4, 4*r+3)        
        y = y + 1
        x = x + a - 4*r - 3
    end

     Complex(x, y)
end

r = coords(N)
puts r.real + r.imag

ADJACENT = [0+1i, 0-1i, -1+0i, 1+0i, -1-1i, -1+1i, 1-1i, 1+1i ]

matrix = Hash.new(0)
matrix[coords(1)] = 1

i = 2
loop do
    c = coords(i)    
    adj = matrix.select{ |coord, _| ADJACENT.collect{|p| p+c}.include?(coord)}
    sum = adj.values.sum
    matrix[c] = sum    
    i += 1
    if sum > N        
        puts sum
        break
    end
end