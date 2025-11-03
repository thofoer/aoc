aunts = File.readlines("input.txt").map { it.scan(/(\w+): (\d+)/)}.to_a.map(&:to_h)

target = {
    "children" => 3,
    "cats" => 7,
    "samoyeds" => 2,
    "pomeranians" => 3,
    "akitas" => 0,
    "vizslas" => 0,
    "goldfish" => 5,
    "trees" => 3,
    "cars" => 2,
    "perfumes" => 1
}

p aunts.each_with_index.find{|a, i| a.keys.all?{|k| a[k].to_i == target[k]}}.last + 1

res = aunts.each_with_index.find do |a, i| 
    a.keys.all? do |k| 
        v = a[k].to_i
        case k
        when "cats", "trees"
            v >= target[k]
        when "pomeranians", "goldfish"
            v < target[k]
        else
            v == target[k]
        end
    end
end

p res.last + 1