require "z3"
bots = File.read("input.txt").scan(/(-?\d+),(-?\d+),(-?\d+).*?(\d+)/).map{ _1.map(&:to_i)}

x, y, z = Z3.Int(?x), Z3.Int(?y), Z3.Int(?z)

botRanges = bots.size.times.to_a.map{ Z3.Int("range#{_1}") }

optimizer = Z3::Optimize.new

<<<<<<< Updated upstream
def manhattan(x, y, z) = x.abs + y.abs + z.abs
=======
def z3Abs(n) = Z3.IfThenElse(n < 0, -n, n)
def manhattan(x, y, z) = z3Abs(x) + z3Abs(y) + z3Abs(z) 
>>>>>>> Stashed changes

botRanges.each.with_index do |botrange, i|    
    bx, by, bz, range = bots[i]
    optimizer.assert( botrange == Z3.IfThenElse( manhattan(x - bx, y - by, z - bz) <= range, 1, 0))    
end

rangeCount = Z3.Int "sum"
distance   = Z3.Int "dist"

optimizer.assert(rangeCount == Z3.Add(*botRanges) )
optimizer.assert(distance   == manhattan(x, y, z))

optimizer.maximize(rangeCount)
optimizer.minimize(distance)
#optimizer.maximize(distance)
optimizer.check()
#p optimizer.model

p optimizer.model.model_eval(x + y + z).to_i