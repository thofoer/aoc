commands = File.readlines("input.txt").map { it.scan(/(toggle|on|off) (\d+),(\d+).*?(\d+),(\d+)/).to_a.flatten}

lights = Hash.new(0)

commands.each do |c, x1, y1, x2, y2|
    x1.to_i.upto(x2.to_i) do |x|
        y1.to_i.upto(y2.to_i) do |y|
            coord = Complex(x,y)
            if (c=="on")
                lights[coord] = lights[coord] + 1
            elsif (c=="off")
                lights[coord] = lights[coord] > 0 ?  lights[coord] - 1 : 0
            else
                lights[coord] = lights[coord] + 2
            end
        end
    end
end

puts lights.values.sum