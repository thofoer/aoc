input = File.read("input.txt").split("\n")

@width, @height = input[0].size, input.size
@grid = {}
@beam = Hash.new([])

@step = {:n => (0-1i), :e => (1+0i), :s => (0+1i), :w => (-1+0i)}

input
    .each
    .with_index do |l,y|
        
        l.chomp.each_char.with_index do |c,x| 
            @grid[Complex(x,y)] = c if c != ?.
        end
end

def dump(pos)
    (0...@height).each do |y|
        print "#{ '%2d' % (y+1)} "
        (0...@width).each do |x|
            p = Complex(x,y)
            if p==pos
                print ?X
            else
                print @beam.include?(p) ? ?# : @grid.include?(p) ? @grid[p] : ?.
            end
        end
        puts
    end
end

def trace(pos, dir)
       
    return if !(0...@width).include?(pos.real) || !(0...@height).include?(pos.imag)
    
    dirs = @beam[pos]
    return if dirs.include? dir   

    dirs = dirs.clone << dir
    @beam[pos] = dirs

    c = @grid[pos]

    case dir
    when :n
        trace(pos + @step[:w], :w) if c == "\\" || c == ?-
        trace(pos + @step[:e], :e) if c == "/"  || c == ?-
        trace(pos + @step[:n], :n) if c.nil?    || c == ?|
    when :e
        trace(pos + @step[:n], :n) if c == "/"  || c == ?|
        trace(pos + @step[:s], :s) if c == "\\" || c == ?|
        trace(pos + @step[:e], :e) if c.nil?    || c == ?-
    when :s
        trace(pos + @step[:e], :e) if c == "\\" || c == ?-
        trace(pos + @step[:w], :w) if c == "/"  || c == ?-
        trace(pos + @step[:s], :s) if c.nil?    || c == ?|
    when :w
        trace(pos + @step[:n], :n) if c == "\\" || c == ?|
        trace(pos + @step[:s], :s) if c == "/"  || c == ?|        
        trace(pos + @step[:w], :w) if c.nil?    || c == ?-
    end
end

trace((0+0i), :e)

print @beam.keys.size
