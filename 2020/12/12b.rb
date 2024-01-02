pos, waypoint = 0+0i, 10-1i

File.read("input.txt").each_line do |l|
  cmd, value = l.scan(/(.)(\d+)/).flatten
  value = value.to_i

  case cmd
  when ?N
    waypoint += value * (0-1i)
  when ?E
    waypoint += value * (1+0i)
  when ?S
    waypoint += value * (0+1i)
  when ?W
    waypoint += value * (-1+0i)
  when ?L
    waypoint *= -1 if value == 180
    waypoint = Complex(waypoint.imag * -1, waypoint.real) if value == 270
    waypoint = Complex(waypoint.imag, waypoint.real * -1) if value == 90
  when ?R
    waypoint *= -1 if value == 180
    waypoint = Complex(waypoint.imag * -1, waypoint.real) if value == 90
    waypoint = Complex(waypoint.imag, waypoint.real * -1) if value == 270
  when ?F
    pos += value * waypoint
  end
end

puts pos.real.abs + pos.imag.abs
