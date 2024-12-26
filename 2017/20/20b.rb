class Particle
    attr_reader :x, :y, :z, :vx, :vy, :vz, :ax, :ay, :az

    def initialize(values)
        @x, @y, @z, @vx, @vy, @vz, @ax, @ay, @az = values
    end

    def tick
        @vx += @ax
        @vy += @ay
        @vz += @az
        @x  += @vx
        @y  += @vy
        @z  += @vz    
    end

    def dist
        @x.abs + @y.abs + @z.abs
    end
end
particles = File.readlines("input.txt").map{ _1. scan(/(\-?\d+)/).flatten.map(&:to_i)}.map{Particle.new(_1)}

100.times do
    particles.each(&:tick)

    pos = particles.map{ [_1.x, _1.y, _1.z] }.tally.select{|k,v| v > 1}
    
    pos.keys.each{ |c| particles.delete_if{|p| p.x==c[0] && p.y==c[1] && p.z==c[2]}}
    puts particles.size

end