require 'json'

input = File.read("input.json", chomp: true)

p input.scan(/(-?\d+)/).flatten.sum(&:to_i)

def value(obj)
    case obj
    when String
        return 0    
    when Integer
        return obj    
    when Array
        return obj.sum{ value it }
    when Hash
        return obj.value?("red") ? 0 : obj.values.sum{ value it }         
    end    
end

p value JSON.parse(input)