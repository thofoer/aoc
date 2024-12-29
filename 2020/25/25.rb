input = File.readlines("input.txt")
card, door = input[0].to_i, input[1].to_i

def step(n, subject)
    n * subject % 20201227
end

def stepsize(n)
    s = 0
    c = 7
    until c==n do
        s += 1
        c = step(c, 7)   
    end
    s
end

d = door
c = card
stepsize(card).times{ d = step(d, door)} 
stepsize(door).times{ c = step(c, card)}
p c
p d