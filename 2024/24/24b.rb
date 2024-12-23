device = {}
OPS = { "AND" => Integer.public_instance_method(:&), 
        "OR"  => Integer.public_instance_method(:|), 
        "XOR" => Integer.public_instance_method(:^) 
}

$map = {}


x, y = 0, 0

File.read("input.txt").scan(/(([xy]\d\d): ([01]))|((...) (...?) (...) -> (...))/).map(&:compact).map{_1.drop(1)}.each do |line|
    if line.size == 2
        reg, val = line
        device[reg] = -> {val.to_i}        
        x |= 1 << reg[1..].to_i if reg[0]==?x && val==?1
        y |= 1 << reg[1..].to_i if reg[0]==?y && val==?1
    else
        reg1, op, reg2, res = line
        device[res] = -> { OPS[op].bind(device[reg1].call).call(device[reg2].call) }       
        
        $map[res] = [reg1, op, reg2]
        
        # puts "#{res}" if reg1.start_with?(?x) ||reg2.start_with?(?x) ||reg1.start_with?(?y) ||reg2.start_with?(?y) 
       
    end
end
#puts "4444443333333333222222222211111111110000000000"
#puts "5432109876543210987654321098765432109876543210"
#puts 
#puts " "+"%045b" % x
#puts " "+"%045b" % y
#puts "----------------------------------------------"
#
#puts (0..45).map{ ?z+("%02d" % _1) }.reverse.map{device[_1].call}.join
#
#
#puts "%b" % ("111110011110001000001100000011101111011001101".to_i(2)+"111000111001101111001010100011010100000011001".to_i(2))



###    4444443333333333222222222211111111110000000000
###    5432109876543210987654321098765432109876543210
###    
###     111110011110001000001100000011101111011001101
###     111000111001101111001010100011010100000011001
###    ----------------------------------------------
###    1110111011000111011010110100110111011011100110
###                                     ^             
###    z12: fgc <-> z12
###    								 
###    4444443333333333222222222211111111110000000000
###    5432109876543210987654321098765432109876543210
###    
###     111110011110001000001100000011101111011001101
###     111000111001101111001010100011010100000011001
###    ----------------------------------------------
###    1110111011000111011010110100111000011011100110
###                    ^
###    
###    z29: z29 <-> mtj
###    
###    4444443333333333222222222211111111110000000000
###    5432109876543210987654321098765432109876543210
###    
###     111110011110001000001100000011101111011001101
###     111000111001101111001010100011010100000011001
###    ----------------------------------------------
###    1110111011000110111010110100111000011011100110
###                ^ 
###    
###    z33: vvm <-> dgr			
###    			
###    4444443333333333222222222211111111110000000000
###    5432109876543210987654321098765432109876543210
###    
###     111110011110001000001100000011101111011001101
###     111000111001101111001010100011010100000011001
###    ----------------------------------------------
###    1110111010111110111010110100111000011011100110		
###    
###    
###    4444443333333333222222222211111111110000000000
###    5432109876543210987654321098765432109876543210
###    
###     000000010000000000000000000000000000000000000
###     000000000000000000000000000000000000000000000
###    ----------------------------------------------
###    0000000100000000000000000000000000000000000000
###            ^ 	
###    z37: z37 <-> dtv
###    
###    -> dgr,dtv,fgc,mtj,vvm,z12,z29,z37


def dump(z, depth=46)
    r1, op, r2 = $map[z]
    if depth==0 || r1.start_with?(?x) || r1.start_with?(?y)
        return "(#{r1} #{op} #{r2})"
    else
        return "(#{dump(r1, depth-1)} #{op} #{dump(r2, depth-1)})"
    end
end

45.times.each do  |i|
    is = ("%02d" % i)
    z = ?z + is
    puts z
    d = dump(z, 2)
    print d    
    puts (d =~ Regexp.new("\\([xy]#{is} XOR [yx]#{is}\\) XOR|XOR \\([xy]#{is} XOR [yx]#{is}\\)")) || i==0 ? "" : "<---- Swap"
    
    puts
    gets
end