input = File.read("input.txt")

state, steps = input.scan(/state (.).*after (\d+) steps/m).flatten

tape = Hash.new("0")
turing = {}
pos = 0

input.scan(/state (.):.*?value (0|1).*?(left|right).*?state (.).*?value (0|1).*?(left|right).*?state (.)./m).each do |state, *v|
    turing[state] = v
end

steps.to_i.times do
    s = turing[state] 
    o = tape[pos] == ?0 ? 0 : 3       
    tape[pos] = s[o]
    pos  += s[o+1] == "right" ? 1 : -1
    state = s[o+2]
end

p tape.values.count(?1)