require "z3"
bots = File.read("input.txt").scan(/(-?\d+),(-?\d+),(-?\d+).*?(\d+)/).map{ it.map(&:to_i)}

x, y, z = Z3.Int(?x), Z3.Int(?y), Z3.Int(?z)

botRanges = bots.size.times.to_a.map{ Z3.Int("range#{it}") }

optimizer = Z3::Optimize.new

def z3Abs(n) = Z3.IfThenElse(n > 0, n, -n)
def manhattan(x, y, z) = z3Abs(x) + z3Abs(y) + z3Abs(z) 

botRanges.each.with_index do |botrange, i|    
    bx, by, bz, range = bots[i]
    optimizer.assert( botrange == Z3.IfThenElse( manhattan(x - bx, y - by, z - bz) <= range, 1, 0))    
end

rangeCount   = Z3.Int "sum"
distFromZero = Z3.Int "dist"

optimizer.assert(rangeCount   == Z3.Add(*botRanges) )
optimizer.assert(distFromZero == z3Abs(x) + z3Abs(y) + z3Abs(z))

optimizer.maximize(rangeCount)
optimizer.minimize(distFromZero)
#optimizer.maximize(distFromZero)
optimizer.check()
#p optimizer.model

p [x, y, z].sum{optimizer.model[it].to_i}
#p optimizer.model[x].to_i+ optimizer.model[y].to_i+ optimizer.model[z].to_i