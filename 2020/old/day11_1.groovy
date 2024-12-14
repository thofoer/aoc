input="""L.LL.LL.LL
LLLLLLL.LL
L.L.L..L..
LLLL.LL.LL
L.LL.LL.LL
L.LLLLL.LL
..L.L.....
LLLLLLLLLL
L.LLLLLL.L
L.LLLLL.LL"""

array = input.split("\n").collect { it.split("") };

def getPos(a,x, y)  {
        if (x<0 || y<0 || x>=a[0].size() || y>=a.size()) {
                return []
        }
        return a[y][x]
}

def getAdjacent(a, x, y) {
        [ getPos(a, x-1, y-1), getPos(a,x-1, y), getPos(a,x-1, y+1),
          getPos(a, x, y-1),  getPos(a,x, y+1),
          getPos(a, x+1, y-1), getPos(a,x+1, y), getPos(a,x+1, y+1) ].flatten()
}

def step() {
changed = false
newArray = array.collect { it.collect{ it }}

for(col=0; col<newArray [0].size(); col++) {
        for(row=0; row<newArray .size(); row++) {
                adj = getAdjacent(array, col, row)
                if (getPos(newArray, col, row)=="L" && adj.count("#")==0) {
                        newArray[row][col] = "#"
                        changed = true
                }
                else if (getPos(newArray, col, row)=="#" && adj.count("#")>=4) {
                        newArray[row][col] = "L"
                        changed = true
                }

        }
}
array=newArray
changed
}
z=0
while(step()) { z++ }
println z
println array.flatten().count("#")

