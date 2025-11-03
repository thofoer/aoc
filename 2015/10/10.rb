s = File.read("input.txt")

def step(str)
    str.to_enum(:scan, /((?<a>.)\k<a>*)/).map { Regexp.last_match }.map{ it[0] }.map{ "#{it.length}#{it[0]}" }.join    
end

40.times { s = step(s) }
p s.length
10.times { s = step(s) }
p s.length

