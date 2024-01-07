
input=""".#.
..#
###"""

inputgrid = input.split("\n").collect { it.split("") } 

xMin = 0
xMax = inputgrid [0].size()
yMin = 0
yMax = inputgrid.size()
zMin = 0
zMax = 1
wMin = 0
wMax = 1

offsets = (-1..1).collectMany { x-> (-1..1).collectMany { y-> (-1..1).collectMany { z-> (-1..1).collect { w->[x,y,z,w] } } } }
offsets.remove([0,0,0,0])

grid=[:]

(0..<xMax).forEach { x-> (0..<yMax).forEach { y -> grid[[x, y, 0, 0]] = inputgrid[x][y] }}

def neighbours(coords) {
   offsets.collect { grid[coords[0]+it[0], coords[1]+it[1], coords[2]+it[2], coords[3]+it[3]] }     
}

def step() {
    coords= (xMin..<xMax).collectMany { x-> (yMin..<yMax).collectMany { y-> (zMin..<zMax).collectMany { z-> (wMin..<wMax).collect { w->[x,y,z,w] } } } }
    coords.forEach { 

        p = grid[it]
        n = neighbours(it).count("#")
        if (p=="#") {
            if (n!=2 && n!=3) {
                newGrid.remove(it)
            }
        }
        else {
            if (n==3) {
                newGrid[it] = "#"
            }
        }
        
    }
}



6.times {

    newGrid = grid.clone()
   
    xMax++
    yMax++
    zMax++
    wMax++
    xMin--
    yMin--
    zMin--
    wMin--
    step()
    grid = newGrid

}
println grid.entrySet().collect{ it.getValue() }.count("#")

