input = File.read("input.txt").to_i

MAX = 1000000
a = [0] * (MAX+1)
1.upto(MAX) do |n|
    (n..MAX).step(n) do |i|
        a[i] = a[i] + n*10
    end    
end

p a.find_index{|i| i > input}
