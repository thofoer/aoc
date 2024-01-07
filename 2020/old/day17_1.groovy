
input="""#.......
.#..#..#
....#.#.
.##..#.#
#######.
#...####
###.##..
.##.#.#."""

inputgrid = input.split("\n").collect { it.split("") } 

xMin = 0
xMax = inputgrid [0].size()
yMin = 0
yMax = inputgrid.size()
zMin = 0
zMax = 1

offsets = (-1..1).collectMany { x-> (-1..1).collectMany { y-> (-1..1).collect { z->[x,y,z] } } }
offsets.remove([0,0,0])

grid=[:]

(0..<xMax).forEach { x-> (0..<yMax).forEach { y -> grid[[x, y, 0]] = inputgrid[x][y] }}

def neighbours(coords) {
   offsets.collect { grid[coords[0]+it[0], coords[1]+it[1], coords[2]+it[2]] }     
}

def step() {
    coords= (xMin..<xMax).collectMany { x-> (yMin..<yMax).collectMany { y-> (zMin..<zMax).collect { z->[x,y,z] } } }
//println coords.size()
    coords.forEach { 

        p = grid[it]
        n = neighbours(it).count("#")
        if (p=="#") {
            if (n!=2 && n!=3) {
                newGrid.remove(it)
//println "lösche ${it}"
            }
        }
        else {
            if (n==3) {
                newGrid[it] = "#"
//println "setze ${it}"
            }
        }
  //   println  " ${it} ${p} ${n}" 
        
    }
}



6.times {

    newGrid = grid.clone()
   
    xMax++
    yMax++
    zMax++
    xMin--
    yMin--
    zMin--
 step()
    grid = newGrid

}
println grid.entrySet().collect{ it.getValue() }.count("#")


