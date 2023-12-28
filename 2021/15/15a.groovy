#!/usr/bin/groovy
matrix  = new File('input.txt').text.split("\n").collect{ it.split("").collect{ it as Integer } }

max = matrix.size()-1
range = (0..max)
risk = range.collect{ [2**30] * (max+1) }

risk[0][0]=0
def adjacentCoords(x, y) {
       [[x-1,y], [x, y-1], [x+1, y], [x, y+1]]
          .findAll{ range.contains(it[0]) && range.contains(it[1]) }
}

ready = false
while(!ready) {
    ready = true
    range.each{ x ->
        range.each{ y -> 
            adjacentCoords(x,y).each{
                newRisk = risk[y][x] + matrix[it[1]][it[0]]
                if (risk[it[1]][it[0]] > newRisk) {
                    risk[it[1]][it[0]] = newRisk
                    ready = false
                }
            }
        }
    }
}
println risk[-1][-1]
