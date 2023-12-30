prg = File.read("input.txt")
          .split("\n")
          .map{ |l| l.split(" ") }
          .map{ |cmd, arg| [cmd.to_sym, arg.to_i] }

ptr = 0
acc = 0
visited = Set.new

until visited.include?(ptr) do
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

print acc