#!/usr/bin/groovy
input = new File('input.txt').text.split("\n\n")
dots  = input[0].split("\n").collect{ it.split(",").collect{ it as Integer } }.collectEntries{ [it, true] }
folds = input[1].split("\n").collect{ it.substring(11).split("=") }.collect{ [it[0], it[1] as Integer] }

width  = dots.collect{ it.key[0] }.max()
height = dots.collect{ it.key[1] }.max()

folds.each{ 
    pos = it[1]
    if (it[0]=="y") {
        dots.findAll{ it.key[1] > pos }
            .each {
                dots.remove(it.key) 
                dots[it.key[0], 2*pos-it.key[1]] = true
            }
        height >>= 1
    }
    else {
        dots.findAll{ it.key[0] > pos }
            .each {
                dots.remove(it.key)
                dots[2*pos-it.key[0], it.key[1]] = true
            }
        width >>= 1
    }
}
matrix = []
(height+1).times{ matrix << [' ']*(width+1) }

dots.each { 
    matrix[it.key[1]][it.key[0]] = "*"
}

println matrix.collect{ it.join() }.join("\n")

