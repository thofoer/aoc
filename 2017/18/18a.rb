prg = File.readlines("input.txt").map{|l| l.split}

vars = Hash.new(0)

ptr = 0

lastSound = nil

loop do
    cmd = prg[ptr] 
    op, arg1, arg2 = cmd
    val2 = arg2 =~ /[a-z]/ ? vars[arg2] : arg2.to_i
    case op
        when "snd" then lastSound = vars[arg1]
        when "set" then vars[arg1] = val2
        when "add" then vars[arg1] += val2
        when "mul" then vars[arg1] *= val2
        when "mod" then vars[arg1] %= val2
        when "rcv" then (puts lastSound; break) unless vars[arg1] == 0
        when "jgz" then ptr += val2 unless vars[arg1] == 0
    end
    ptr += 1 unless op == "jgz" && vars[arg1] != 0
    break if ptr >= prg.size
    #puts "#{vars}  #{lastSound.inspect}"
    #gets    
end
