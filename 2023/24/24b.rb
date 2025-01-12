require "z3"

solver = Z3::Solver.new
x, y, z, tx, ty, tz = %w[x y z tx ty tz].map(&Z3.method(:Int))

File.read("input.txt").split("\n").map{it.scan(/(-?\d+)/).flatten.map(&:to_i)}.each.with_index do |(hx, hy, hz, vx, vy, vz), i|
    ht = Z3.Int "t#{i}"
    solver.assert x + ht * tx == hx + ht * vx
    solver.assert y + ht * ty == hy + ht * vy
    solver.assert z + ht * tz == hz + ht * vz
end

p solver.model.model_eval(x + y + z).to_i if solver.satisfiable?
