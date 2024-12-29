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
    [m.last, m[1..-2], m.first].flatten,
    m.map(&:reverse)
   ]
end

def rotate(m)
    [
         m,
         m.size.times.map {|i| m.map{_1[i]}.join.reverse},
         [m.last, m[1..-2], m.first].flatten.map(&:reverse),
         m.size.times.map {|i| m.map{_1[m.size-i-1]}.join}
    ]
end

def patterns(m)
    rotate(m).flat_map{flip(_1)}.uniq
end

def toPixel(img)
    res = Set.new
    img.each.with_index do |l,y|
        l.each_byte.with_index do |b,x|
            res << Complex(x,y) if b == 35
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

$rules2 = {}
$rules3 = {}
input.each do |k,v|  
    target = v[0].size == 3 ? $rules2 : $rules3  
    patterns(k).each{ target[toPixel(_1)] = toPixel(v)}
end


TWO   = [0+0i, 1+0i, 0+1i, 1+1i]
THREE = [0+0i, 1+0i, 2+0i, 0+1i, 1+1i, 2+1i, 0+2i, 1+2i, 2+2i]

def grow3(state, size)
    #p size
    #p state 
    #puts "========== grow3"
    newState = Set.new
    (0...size/3).each do |x|        
        (0...size/3).each do |y|            
            pattern = THREE.map{ _1 + Complex(3*x, 3*y)}.to_set.intersection(state).to_a.map{ _1 - Complex(3*x, 3*y)}.to_set
            #p "#{x} #{y} #{pattern}"
            #p $rules3[pattern]            
            #gets
            $rules3[pattern].to_a.map{ _1 + Complex(4*x, 4*y) }.each{ newState << _1}
        end
    end
    newState
end

def grow2(state, size)
    #p size
    #p state 
    #puts "========== grow2"
    newState = Set.new
    (0...size/2).each do |x|        
        (0...size/2).each do |y|            
            pattern = TWO.map{ _1 + Complex(2*x, 2*y)}.to_set.intersection(state).to_a.map{ _1 - Complex(2*x, 2*y)}.to_set
            #p "#{x} #{y} #{pattern}"
            #p $rules2[pattern]  
            #gets
            $rules2[pattern].to_a.map{ _1 + Complex(3*x,   3*y)   }.each{ newState << _1}
        end
    end
    newState
end

state = toPixel([".#.", "..#", "###"])


size = 3
18.times do 

    if size % 2 == 0
        state = grow2(state, size)
        size = size/2 * 3
    else
        state = grow3(state, size)
        size = size/3 * 4
    end
    #dump(state, size)
end
p state.size