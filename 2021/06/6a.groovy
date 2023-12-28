#!/usr/bin/groovy
fish = new File('input.txt').text.split(",").collect { it as Integer }

80.times {
    newFish = []
    fish.each {
        if (it==0) {
            newFish <<= 6
            newFish <<= 8
        }
        else {
            newFish <<= it-1
        }
    }
    fish = newFish
}
println fish.size() 
