device = {}
OPS = { "AND" => Integer.public_instance_method(:&), 
        "OR"  => Integer.public_instance_method(:|), 
        "XOR" => Integer.public_instance_method(:^) 
}

x, y = 0, 0

File.read("input1.txt").scan(/(([xy]\d\d): ([01]))|((...) (...?) (...) -> (...))/).map(&:compact).map{_1.drop(1)}.each do |line|
    if line.size == 2
        reg, val = line
        device[reg] = -> {val.to_i}        
        x |= 1 << reg[1..].to_i if reg[0]==?x && val==?1
        y |= 1 << reg[1..].to_i if reg[0]==?y && val==?1
    else
        reg1, op, reg2, res = line
        device[res] = -> { OPS[op].bind(device[reg1].call).call(device[reg2].call) }       
       # puts "#{res}" if reg1.start_with?(?x) ||reg2.start_with?(?x) ||reg1.start_with?(?y) ||reg2.start_with?(?y) 
       
    end
end
puts "4444443333333333222222222211111111110000000000"
puts "5432109876543210987654321098765432109876543210"
puts 
puts " "+"%045b" % x
puts " "+"%045b" % y
puts "----------------------------------------------"

puts (0..45).map{ ?z+("%02d" % _1) }.reverse.map{device[_1].call}.join


puts "%b" % ("111110011110001000001100000011101111011001101".to_i(2)+"111000111001101111001010100011010100000011001".to_i(2))

