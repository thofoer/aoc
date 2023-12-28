#!/usr/bin/groovy
matrix = new File('input.txt').text.split("\n").collect{ it.split("").collect{ it as Integer } }

widthRange  = (0..matrix[0].size()-1)
heightRange = (0..matrix.size()-1)

def adjacentCoords(x, y) {
    ([-1,0,1].collectMany{ xPos-> [-1,0,1].collect{ yPos -> [x+xPos, y+yPos] } }-[[x,y]])
        .findAll{ widthRange.contains(it[0]) && heightRange.contains(it[1]) }
}

def incMatrix() {
    widthRange.each{ x-> heightRange.each{ y -> matrix[y][x] += 1 } }
}

def flashMatrix(flashed) {
    flashCount = 0
    widthRange.each{ x-> 
        heightRange.each{ y ->
           if ( matrix[y][x] > 9 && !flashed[[x][y]]) {
                flashCount += 1
                flashed << [[x,y]: true]
                adjacentCoords(x,y).each { matrix[it[1]][it[0]] += 1 }
           } 
        } 
    }
    flashed.keySet().each{ matrix[it[1]][it[0]] = 0 }
    flashCount > 0 ? flashCount + flashMatrix(flashed) : 0 
}

def step() {
    incMatrix()
    flashMatrix([:])
}

def dump() {
    println matrix.collect{ it.join() }.join("\n")
}

dump()
println "----------"
count = 0
while (!matrix.flatten().every{ it == 0 }) {
    step()
    count += 1
}
dump()
println count
