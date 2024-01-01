@seats = {}
File.read("sample.txt").each_line.with_index do |l,y|
    l.each_char.with_index do |c,x|
        @seats[Complex(x,y)] = false if c == ?L
    end
end

def adjacent(p)
    [-1-1i, 0-1i, 1-1i, 1+0i, 1+1i, 0+1i, -1+1i, -1+0i].map{|d| @seats[d + p] }.count(true)
end


def step
    change = false
    newSeats = @seats.dup
    @seats.keys.each do |p|
        (newSeats[p] = true; change=true) unless @seats[p]       
        (newSeats[p] = false; change = true) if adjacent(p) >= 4
    end    
    @seats = newSeats
    change
end

while step do
    puts "xXXXX"
end

puts @seats.values.count(true)
