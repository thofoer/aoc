prg = File.readlines("input.txt").map{|l| l.split}

vars = Hash.new(0)

ptr = 0

count = 0

loop do
    cmd = prg[ptr] 
    #p cmd
    op, arg1, arg2 = cmd
    val1 = arg1 =~ /[a-z]/ ? vars[arg1] : arg1.to_i
    val2 = arg2 =~ /[a-z]/ ? vars[arg2] : arg2.to_i
    case op
        
        when "set" then vars[arg1] = val2
        when "sub" then vars[arg1] -= val2
        when "mul" then vars[arg1] *= val2; count += 1
        when "jnz" then ptr += val2 if val1 != 0
    end
    ptr += 1 unless op == "jnz" && val1 != 0
    #puts "#{vars}"
    break if ptr >= prg.size
   
 #   gets    
end

p count