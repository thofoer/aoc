PRG = File.readlines("input.txt").map{ it.scan(/(\w+) ([ab+\-0-9]+),? ?(.*)/)}.flatten(1)

def solve(a)
    z = 0
    reg = {?a => a, ?b => 0}

    while z < PRG.size
        c, r, o = PRG[z]

        case c
            when "hlf" then reg[r] /= 2; 
            when "tpl" then reg[r] *= 3; 
            when "inc" then reg[r] += 1;
            when "jmp" then z += r.to_i - 1
            when "jie" then z += o.to_i - 1 if reg[r].even?
            when "jio" then z += o.to_i - 1 if reg[r] == 1
        end
        z += 1
    end
    reg[?b]
end

p solve(0), solve(1)