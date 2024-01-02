@seats = {}
File.read("input.txt").each_line.with_index do |l,y|
    l.each_char.with_index do |c,x|
        @seats[Complex(x,y)] = false if c == ?L
    end
end

def adjacent(p)
    [-1-1i, 0-1i, 1-1i, 1+0i, 1+1i, 0+1i, -1+1i, -1+0i].map{|d| @seats[d + p] }.count(true)
end

def dump
    (0...10).each do |y|
        (0...10).each do |x|
            p = Complex(x,y)
            case @seats[p]
            when nil
                print ?.
            when true
                print ?#
            when false
                print ?L
            end
        end
        puts
    end
end


def step
    newSeats = @seats.dup
    @seats.keys.each do |p|
        newSeats[p] = true  if adjacent(p) == 0
        newSeats[p] = false if adjacent(p) >= 4
    end
    changed = @seats !=  newSeats
    @seats = newSeats
    changed
end



while step do end

puts @seats.values.count(true)
