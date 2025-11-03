HAPPY = {}
names = []

File.readlines("input.txt").map { it.scan(/(\w+).*(gain|lose) (\d+).* to (\w+)/).to_a.flatten}.each do |a, s, v, b|
    names << a
    HAPPY[[a,b]] = (s=="lose" ? -1 : 1) * v.to_i
end
names.uniq!
names.each do |n|
    HAPPY[["me", n]] = HAPPY[[n, "me"]] = 0    
end

def calc(names)
    arr = names.permutation.map do |perm|
        perm << perm.first
        perm.each_cons(2).sum{ |a,b| HAPPY[[a,b]] + HAPPY[[b,a]]}
    end
    arr.max 
end

p calc(names)
p calc(names << "me")
