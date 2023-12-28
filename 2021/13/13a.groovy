#!/usr/bin/groovy
input = new File('input.txt').text.split("\n\n")
dots  = input[0].split("\n").collect{ it.split(",").collect{ it as Integer } }.collectEntries{ [it, true] }
folds = input[1].split("\n").collect{ it.substring(11).split("=") }.collect{ [it[0], it[1] as Integer] }

println dots.size()
folds[0..0].each{ 
    pos = it[1]
    if (it[0]=="y") {
        maxY = dots.collect{ it.key[1] }.max()
        dots.findAll{ it.key[1] > pos }
            .each {
                dots.remove(it.key) 
                dots[it.key[0], maxY-it.key[1]] = true
            }
    }
    else {
        println "X "+dots 
        maxX = dots.collect{ it.key[0] }.max()
        println "maxX="+maxX+"   pos="+pos
        dots.findAll{ it.key[0] > pos }
            .each {
                println "--->"+it.key+" => "+[maxX-it.key[0], it.key[1]]
                dots.remove(it.key)
                dots[maxX-it.key[0], it.key[1]] = true
            }
    }
}
println dots
println dots.size()

