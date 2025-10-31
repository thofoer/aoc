commands = File.readlines("input.txt").map { it.scan(/(toggle|on|off) (\d+),(\d+).*?(\d+),(\d+)/).to_a.flatten}

lights = Set.new

commands.each do |c, x1, y1, x2, y2|
    x1.to_i.upto(x2.to_i) do |x|
        y1.to_i.upto(y2.to_i) do |y|
            coord = Complex(x,y)
            if (c=="on")
                lights << coord
            elsif (c=="off")
                lights.delete coord
            else
                if lights.include? coord
                    lights.delete coord
                else
                    lights << coord
                end
            end
        end
    end
end

puts lights.size