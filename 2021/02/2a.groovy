#!/usr/bin/groovy
inputText = new File('input.txt').text
input = inputText.split("\n")
position = input.findAll{ it.startsWith("forward") }.collect{ it.substring(8) as Integer }.sum()
down = input.findAll{ it.startsWith("down") }.collect{ it.substring(5) as Integer }.sum()
up = input.findAll{ it.startsWith("up") }.collect{ it.substring(3) as Integer }.sum()
result = position * (down-up)
println(result)
