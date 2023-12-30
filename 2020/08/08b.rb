prg = File.read("input.txt")
          .split("\n")
          .map{ |l| l.split(" ") }
          .map{ |cmd, arg| [cmd.to_sym, arg.to_i] }


def solve(prg)          
    ptr, acc = 0, 0    
    visited = Set.new

    until visited.include?(ptr) || ptr > prg.size do
        cmd, arg = prg[ptr]
        visited << ptr
        case cmd
        when :acc
            acc += arg        
        when :jmp
            ptr += arg - 1           
        end
        ptr += 1
    end
    ptr > prg.size ? acc : nil
end

SWITCH = { :nop => :jmp, :jmp => :nop }

(0...prg.size).each do |i|    
    next if prg[i].first == :acc
    prg[i][0] = SWITCH[prg[i][0]]
    res = solve(prg)
    if res
        print res
        break
    end
    prg[i][0] = SWITCH[prg[i][0]]
end


