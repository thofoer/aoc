#!/usr/bin/groovy
matrix = new File('input.txt').text.split("\n").collect{ it.split("").collect{ it as Integer } }

widthRange  = (0..matrix[0].size()-1)
heightRange = (0..matrix.size()-1)

def lowPoint(x, y) {
    adjacent = [[x-1,y], [x, y-1], [x+1, y], [x, y+1]]
    adjacent.findAll{ widthRange.contains(it[0]) && heightRange.contains(it[1]) }
            .collect{ matrix[it[1]][it[0]] }
            .every{ it > matrix[y][x] }
       ? matrix[y][x] + 1
       : 0
}
sum = 0
widthRange.each { x ->
        heightRange.each{ y ->
                sum += lowPoint(x,y)
        }
}


println sum
