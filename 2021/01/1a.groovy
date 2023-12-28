#!/usr/bin/groovy
inputText = new File('input.txt').text
input = inputText.split("\n").collect{ it as Integer }
range = 0..(input.size()-2)
println ( range.toList().collect { input[it+1] - input[it] }.count{ it>0 } )
