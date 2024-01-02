DIRS = [ 1+0i, 0+1i, -1+0i, 0-1i ]
pos, dir = 0+0i, 0

File.read("input.txt").each_line do |l|
  cmd, value = l.scan(/(.)(\d+)/).flatten
  value = value.to_i

  case cmd
  when ?N
    pos += value * (0-1i)
  when ?E
    pos += value * (1+0i)
  when ?S
    pos += value * (0+1i)
  when ?W
    pos += value * (-1+0i)
  when ?L
    dir = (dir - value / 90) % 4
  when ?R
    dir = (dir + value / 90) % 4
  when ?F
    pos += value * DIRS[dir]
  end
end

puts pos.real.abs + pos.imag.abs

