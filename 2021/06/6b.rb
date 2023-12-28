#!/usr/bin/ruby
fish = [0] * 9
File.read('input.txt').split(",").each { |i| fish[i.to_i] += 1 }

256.times { |day|
    fish[(day + 7) % 9] += fish[day % 9]
}
puts fish.sum()
