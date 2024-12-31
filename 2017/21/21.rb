input = {}
File.readlines("input.txt").map{_1.scan(/([.#]+)/)}.each do |r|
    if r.size == 5
        input[r[0..1].flatten] = r[2..].flatten
    else
        input[r[0..2].flatten] = r[3..].flatten
    end
end

def dump(m)
    m.each{p _1}
    puts
end

def flip(m)
   [
    m,
    m.reverse,
    m.map(&:reverse)
   ]
end

def rotate(m)
    [
         m,
         m.size.times.map {|i| m.map{_1[i]}.join.reverse},
         m.reverse.map(&:reverse),
         m.size.times.map {|i| m.map{_1[m.size-i-1]}.join}
    ]
end

def patterns(m)
    rotate(m).flat_map{flip(_1)}.uniq
end

def toPixel(img)
    res = Set.new
    img.each.with_index do |l,y|
        l.each_char.with_index do |b,x|
            res << Complex(x,y) if b == ?#
        end
    end
    res
end

def dump(pixel, size)
    (0...size).each do |y|
        (0...size).each do |x|
            print pixel.include?(Complex(x,y)) ? ?# : ?.
        end
        puts 
    end
    puts "+++++++ #{pixel.size} +++++"
    puts
end

$rules2, $rules3 = {}, {}

input.each do |k,v|  
    target = v[0].size == 3 ? $rules2 : $rules3  
    patterns(k).each{ target[toPixel(_1)] = toPixel(v)}
end

TWO    = [0+0i, 1+0i, 0+1i, 1+1i]
THREE  = [0+0i, 1+0i, 2+0i, 0+1i, 1+1i, 2+1i, 0+2i, 1+2i, 2+2i]
PARAMS = { true => [2, $rules2, TWO], false => [3, $rules3, THREE] }

def grow(state, size)
    diff, rules, templ = PARAMS[size.even?]

    newState = Set.new
    (0...size/diff).each do |x|        
        (0...size/diff).each do |y|            
            pattern = templ.map{ _1 + Complex(diff*x, diff*y)}.to_set.intersection(state).to_a.map{ _1 - Complex(diff*x, diff*y)}.to_set            
            rules[pattern].to_a.map{ _1 + Complex((diff+1)*x, (diff+1)*y) }.each{ newState << _1}
        end
    end
    [newState, size/diff * (diff+1) ]
end

def solve(count)
    state = toPixel([".#.", "..#", "###"])
    size = state.size
    #sss = Time.now
    count.times do  |z|
        state, size = grow(state, size)        
        #puts "#{"%2d" % (z+1)} #{"%5d" % size} #{"%8d" % state.size} #{"%6.2f" % (Time.now - sss)}"
        #sss = Time.now
    end
    state.size
end

p solve(5)
p solve(18)