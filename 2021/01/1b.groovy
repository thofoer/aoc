#!/usr/bin/groovy
inputText = new File('input.txt').text
input = inputText.split("\n").collect{ it as Integer }
slices = (0..(input.size()-3)) .toList().collect { input[it..it+2].sum() } 
result = (0..(slices.size()-2)).toList().collect { slices[it+1] - slices[it] }.count{ it>0 } 
println(result)
