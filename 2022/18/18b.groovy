cubes = new File('input2.txt').text.split("\n").collect { Eval.me("["+it+"]")}.toSet()
values = cubes.flatten()
maxCoord = values.max()+1
minCoord = values.min()-1

def touches(a, b) {
    (0..2).collect{ Math.abs(a[it] - b[it])}.sum() == 1
}

def adjacent(a) {
    x = a[0]
    y = a[1]
    z = a[2]

    [[x+1, y, z], [x-1, y, z], [x, y+1, z], [x, y-1, z], [x, y, z+1], [x, y, z-1]]
            .findAll {
                it[0]>=minCoord && it[1]>=minCoord && it[2]>=minCoord &&
                it[0]<=maxCoord && it[1]<=maxCoord && it[2]<=maxCoord
            }
}

def countTouchingSides(o) {
    cubes.collect{ touches(it, o) ? 1 : 0 }.sum()
}

outside = new HashSet()
testCoords = [[minCoord,minCoord,minCoord]]

while(!testCoords.isEmpty()) {
    next = testCoords.pop()
    neighbors = adjacent(next) - cubes
    foundNew = neighbors - outside
    outside.addAll(foundNew)
    testCoords.addAll(foundNew)
}

println outside.collect{ countTouchingSides(it) }.sum()

