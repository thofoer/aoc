fish = [0] * 9
File.read("input.txt").split(?,).each { fish[_1.to_i] += 1 }

256.times { |day|
    fish[(day + 7) % 9] += fish[day % 9]
}
puts fish.sum
