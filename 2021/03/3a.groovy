#!/usr/bin/groovy 
inputText = new File('input.txt').text
input = inputText.split("\n")

rows = input.size()
cols = input[0].length()

bits = input.collect { it.split("") }
            .inject((1..cols).collect{""}) { acc, value -> (0..cols-1).each{ acc[it] += value[it]}; acc }
            .collect{ it.count("1") }
            .collect{ it > rows/2 ? 1 : 0 }
            .join()

gamma = Integer.parseInt(bits, 2)
epsilon = (1<<cols) - gamma - 1
println(gamma * epsilon)

