map = Hash.new{|h,k| h[k] = []}
food = []
File.read("input.txt").scan(/([a-z ]+)\(contains ([a-z, ]+)\)/).each do |ing, all|     
     f = ing.split(" ")
     food.push *f      
     all.split(?,).each{ map[_1.strip] << Set.new(f) }    
end

allIngredients = map.values.flatten.inject(&:+)
allergenes =  Set.new(map.keys)

allToIng = {}
until allToIng.size == allergenes.size do
    map.map{|k,v| [k, v.inject(&:intersection)]}.select{|_,a| a.size==1}.each {|i,a| allToIng[i] = a.first}
    allToIng.each{ |_,i| map.each{|_,set| set.each {_1.delete(i)}}}     
end

allergene = Set.new(allToIng.values)
nonAllergene = allIngredients.reject{|a| allergene.include?(a)}

p food.count{nonAllergene.include? _1}

puts allToIng.sort_by{ |k,_|k }.map{_1.last}.join(?,)