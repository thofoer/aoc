grid = Hash.new("")
pos = nil

File.readlines("input.txt").each_with_index do |l, y|
    l.chars.each.with_index do |c, x|     
      grid[Complex(x,y)] = c.sub(" ", "")
      pos = Complex(x,y) if y == 0 && c==?|
    end
end

DIRS = [0+1i, -1+0i, 0-1i, 1+0i]
dir, steps = 0, 0

loop do
   # p "#{pos} '#{grid[pos]}' #{dir}"
   steps += 1
    pos += DIRS[dir]   
    print grid[pos] if grid[pos] =~ /[A-Z]/
    break if grid[pos].empty?           
    dir = (dir + (grid[pos+DIRS[(dir-1)%4]] == "" ? 1 : -1)) % 4 if grid[pos] == ?+           
end
puts
puts steps