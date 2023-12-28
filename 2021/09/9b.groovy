#!/usr/bin/groovy
matrix = new File('input.txt').text.split("\n").collect{ it.split("").collect{ it as Integer } }

widthRange  = (0..matrix[0].size()-1)
heightRange = (0..matrix.size()-1)

def adjacentCoords(x, y) {
    [[x-1,y], [x, y-1], [x+1, y], [x, y+1]]
        .findAll{ widthRange.contains(it[0]) && heightRange.contains(it[1]) }
}

def isLowPoint(x, y) {
    adjacentCoords(x, y)
            .collect{ matrix[it[1]][it[0]] }
            .every{ it > matrix[y][x] }
}

def markBasin(x, y, markMap) {
    markMap[[x,y]] = true

    adjacentCoords(x, y)
         .findAll{ matrix[it[1]][it[0]] != 9 && 
                   matrix[it[1]][it[0]] > matrix[y][x] && 
                  !markMap[[it[0]][it[1]]] }
         .each {
              markBasin(it[0], it[1], markMap)
         }
    markMap
}

coords = widthRange.collectMany{ x -> heightRange.collect{ y -> [x, y] } }
lowPoints = coords.findAll{ isLowPoint(it[0], it[1]) } 

basins = lowPoints.collect{ 
    markBasin(it[0], it[1], [:]).size()
}
println basins.sort()[-1..-3].inject(1){ acc, num -> acc *= num }
