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

1000.times{ particles.each(&:tick)}

s = particles.sort_by(&:dist).first

p particles.index(s)
