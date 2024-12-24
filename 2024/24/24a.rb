device = {}
OPS = { "AND" => Integer.public_instance_method(:&), 
        "OR"  => Integer.public_instance_method(:|), 
        "XOR" => Integer.public_instance_method(:^) 
}

File.read("input.txt").scan(/(([xy]\d\d): ([01]))|((...) (...?) (...) -> (...))/).map(&:compact).map{_1.drop(1)}.each do |line|
    if line.size == 2
        reg, val = line
        device[reg] = -> {val.to_i}        
    else
        reg1, op, reg2, res = line
        device[res] = -> { OPS[op].bind(device[reg1].call).call(device[reg2].call) }       
        puts "#{res}" if reg1.start_with?(?x) ||reg2.start_with?(?x) ||reg1.start_with?(?y) ||reg2.start_with?(?y) 
        #puts "#{reg1} #{reg2}" if reg1.start_with?(?y) &&reg2.start_with?(?y) 
    end
end

puts (0..45).map{ ?z+("%02d" % _1) }.reverse.map{device[_1].call}.join.to_i(2)

