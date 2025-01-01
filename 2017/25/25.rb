input = File.read("input.txt")

state, steps = input.scan(/state (.).*after (\d+) steps/m).flatten

tape = Hash.new("0")
turing = {}
pos = 0

input.scan(/state (.):.*?value (0|1).*?(left|right).*?state (.).*?value (0|1).*?(left|right).*?state (.)./m).each do |state, *v|
    turing[state] = v
end

steps.to_i.times do |i|
    #puts "#{i}, #{pos} #{state}" if i%100000==0
    s = turing[state]
   # p s
    if tape[pos] == ?0
        tape[pos] = s[0]
        pos += (s[1] == "right" ? 1 : -1)
        state = s[2]
    else
        tape[pos] = s[3]
        pos += (s[4] == "right" ? 1 : -1)
        state = s[5]
    end
  #  gets
end
p tape.values.count(?1)