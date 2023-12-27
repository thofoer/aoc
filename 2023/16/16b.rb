input = File.read("input.txt").split("\n")

SIZE  = input.size
@grid = {}
@beam = Hash.new([])

@step = {:n => 0-1i, :e => 1+0i, :s => 0+1i, :w => -1+0i}

input
    .each
    .with_index do |l,y|        
        l.chomp.each_char.with_index do |c,x| 
            @grid[Complex(x,y)] = c if c != ?.
        end
end

def trace(pos, dir)   
    return unless (0...SIZE).include?(pos.real) && (0...SIZE).include?(pos.imag)

    dirs = @beam[pos]
    return if dirs.include? dir   

    @beam[pos] = @beam[pos].dup << dir

    c = @grid[pos]
    case dir
    when :n
        trace(pos + @step[:w], :w) if c == ?\\ || c == ?-
        trace(pos + @step[:e], :e) if c == ?/  || c == ?-
        trace(pos + @step[:n], :n) if c.nil?   || c == ?|
    when :e
        trace(pos + @step[:n], :n) if c == ?/  || c == ?|
        trace(pos + @step[:s], :s) if c == ?\\ || c == ?|
        trace(pos + @step[:e], :e) if c.nil?   || c == ?-
    when :s
        trace(pos + @step[:e], :e) if c == ?\\ || c == ?-
        trace(pos + @step[:w], :w) if c == ?/  || c == ?-
        trace(pos + @step[:s], :s) if c.nil?   || c == ?|
    when :w
        trace(pos + @step[:n], :n) if c == ?\\ || c == ?|
        trace(pos + @step[:s], :s) if c == ?/  || c == ?|        
        trace(pos + @step[:w], :w) if c.nil?   || c == ?-
    end
end

def solve(start, dir)
    @beam = Hash.new([])
    trace(start, dir)
    @beam.keys.size
end

max = 0
SIZE.times do |i|
    max = [max, 
           solve(Complex(i, 0), :s), 
           solve(Complex(0, i), :e), 
           solve(Complex(i, SIZE-1), :n),           
           solve(Complex(i, SIZE-1), :w)
        ].max    
end

puts max