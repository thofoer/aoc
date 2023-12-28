#!/usr/bin/groovy
matrix  = new File('input.txt').text.split("\n").collect{ it.split("").collect{ it as Integer } }
max = matrix.size()
max5 = matrix.size() * 5 -1

matrix5 = (0..max5).collect{ [0] * (max5+1) }

(0..4).each{ tx ->
  (0..4).each{ ty ->
        (0..max-1).each { x->
                 (0..max-1).each { y->
                      n = matrix[y][x]+tx+ty
                      if (n>9) {
                          n=(n%10)+1
                      }
                      matrix5[ty*max+y][tx*max+x] = n
                  }
         }
    }
}


//print matrix5.collect{ it.join() }.join("\n")
matrix=matrix5
max=matrix.size()-1
range = (0..max)
risk = range.collect{ [2**30] * (max+1) }
risk[0][0]=0
def adjacentCoords(x, y) {
       [[x-1,y], [x, y-1], [x+1, y], [x, y+1]]
          .findAll{ range.contains(it[0]) && range.contains(it[1]) }
}
count = 1
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
