#!/usr/bin/groovy
input = new File('input.txt').text.split("\n")
println input.collect{ it.split("\\|")[1].trim().split(" ") }
             .flatten()
             .count{ [2,3,4,7].contains(it.length()) }
