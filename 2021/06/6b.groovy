#!/usr/bin/groovy
fish = [ 0 as BigInteger ] * 9
new File('input.txt').text.split(",").each { fish[it as Integer] += 1 }

256.times {
    fish = fish[1..8] << fish[0] 
    fish[6] += fish[8]
}
println fish.sum()
