#!/usr/bin/groovy
input = new File('input.txt').text.split("\n")
lines = input.collect { it.split("->").collect { it.split(",").collect{ it as Integer } } } 

map = [:]

lines.each { 
    start = it[0]
    end = it[1]
    delta = [end[0] - start[0], end[1] - start[1]].collect{ it > 0 ? 1 : it < 0 ? -1 : 0 } 
    length = 1 + Math.max( Math.abs(end[0] - start[0]), Math.abs(end[1] - start[1]))

    length.times { 
        nextPos = [start[0] + it*delta[0], start[1] + it*delta[1]]
        map[nextPos] =  map[nextPos] ? map[nextPos] + 1 : 1  
    }
}
count = map.values().count{ it > 1 }

//println map.entrySet().join("\n")
println count
