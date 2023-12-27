wind = new File('input2.txt').text

tileWidths = [4, 3, 3, 1, 2]
tileHeights = [1, 3, 3, 4, 2]

tiles = [
        [['#', '#', '#', '#']],

        [['.', '#', '.'],
         ['#', '#', '#'],
         ['.', '#', '.']],

        [['#', '#', '#'],
         ['.', '.', '#'],
         ['.', '.', '#']],

        [['#'],
         ['#'],
         ['#'],
         ['#']],

        [['#', '#'],
         ['#', '#']]
]

bottom = 0
highest = 0
def tileIdx = 0
step = 0

def isWindLeft() {
    wind[step++ % wind.length()] == "<"
}

def dump2(tileIdx, x, y) {
    copy = pit.clone()
    copy = copy.collect{ r -> r.clone()}
    tile = tiles[tileIdx]
    tileHeight = tileHeights[tileIdx]

    for (int iy=0; iy<tileHeight; iy++){
        for (int ix=0; ix<tile[iy].size(); ix++){
            if (tile[tileHeight-iy-1][ix]=='#') {
                pit[y-iy+bottom][x+ix-bottom] = '#'
            }
        }
    }
    pit.reverse().each { println it.join("") }
    println ""
    pit = copy
}

def dump() {
    pit.reverse().each { println it.join("") }
    println ""
}

pit = (0..3).collect{ ['.'] * 7 }

def updatePit(tileIdx) {
    newRows =  (3+tileHeights[(tileIdx+1)%5]) - (pit.size()+bottom-highest)
    //println "newrows ="+newRows
    if (newRows > 0) {
        newRows.times {
            pit.add( ['.'] * 7)
        }
    }
}

def canPush(idx, x, y, pushLeft) {
    if (pushLeft && x==0) {
        return false
    }
    if (!pushLeft && x+tileWidths[idx]==7) {
        return false
    }
    return !isCollision(idx, pushLeft ? x-1 : x+1, y)
}

def canFall(idx, x, y) {
    if (y-tileHeights[idx]+1==bottom) {
        return false
    }
    !isCollision(idx, x, y-1)
}

def isCollision(tileIdx, x, y) {
    tile = tiles[tileIdx]
    tileHeight = tileHeights[tileIdx]

    for (int iy=0; iy<tileHeight; iy++){
        for (int ix=0; ix<tile[iy].size(); ix++){
            if (tile[tileHeight-iy-1][ix]=='#' &&  pit[y-iy+bottom][x+ix-bottom] == '#') {
                return true
            }
        }
    }
    return false
}

def touchDown(tileIdx, x, y) {
    tile = tiles[tileIdx]
    tileHeight = tileHeights[tileIdx]

    for (int iy=0; iy<tileHeight; iy++){
        for (int ix=0; ix<tile[iy].size(); ix++){
            if (tile[tileHeight-iy-1][ix]=='#') {
                pit[y-iy+bottom][x+ix-bottom] = '#'
            }
        }
    }
    tilePos = y
    if (tilePos >= highest) {
        highest = tilePos+1
    }
  //  println "new highest "+highest
    updatePit(tileIdx);
}

def dropTile(idx) {
    y = highest + 3 + tileHeights[idx] -1
    x = 2
    falling = true
    while(falling) {
       // dump2(idx, x, y)
        pushLeft = isWindLeft()
        if (canPush(idx, x, y, pushLeft)) {
            x += pushLeft ? -1 : 1
        }
        if (canFall(idx, x, y)) {
            y--
        } else {
            touchDown(idx, x, y)
            falling = false
        }
    }

}



s = System.currentTimeMillis()
for (int i=0; i<1000; i++)
{
    dropTile(tileIdx++)
    tileIdx = tileIdx % 5
    //dump()

}
println highest
println("" + (System.currentTimeMillis()-s))
