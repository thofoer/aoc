def matrix = new File('input2.txt').text.split("\n").collect{ it.split("").collect{it.charAt(0)}}

class Coord {
    Integer x
    Integer y

    Coord(x ,y) {
        this.x = x
        this.y = y
    }
    String toString() {
        "("+x+","+y+")"
    }
}

class Forest {
    Integer width
    Integer height
    Coord start
    Coord dest
    List<List<Character>> matrix
    List<List<Integer>> dist

    Forest(matrix) {
        this.matrix = matrix
        this.width = matrix[0].size()
        this.height = matrix.size()
        this.dist = new Integer[height][width]
        for(int x=0; x<width; x++) {
            for(int y=0; y<height; y++) {
                dist[y][x] = 1000000
                if (matrix[y][x]=="E") {
                    dest = new Coord(x,y)
                }
                else if (matrix[y][x]=="S") {
                    start = new Coord(x,y)
                    dist[y][x] = 0
                }
            }
        }
    }

    Character elev(x, y) {
        def e = matrix[y][x]
        if (e=='S') {
            e='a'
        }
        if (e=='E') {
            e='z'
        }
        e
    }

    List<Coord> getAdjacent(Coord pos) {
        def res = []
        def current = matrix[pos.y][pos.x]
        def isStart = current=="S"
        if (pos.x>0 && (current-elev(pos.x-1,pos.y) >=-1 || isStart)) {
            res.push(new Coord(pos.x-1, pos.y))
        }
        if (pos.x<width-1 && (current-elev(pos.x+1,pos.y) >=-1|| isStart)) {
            res.push(new Coord(pos.x+1, pos.y))
        }
        if (pos.y>0 && (current-elev(pos.x,pos.y-1) >=-1|| isStart)) {
            res.push(new Coord(pos.x, pos.y-1))
        }
        if (pos.y<height-1 && (current-elev(pos.x,pos.y+1) >=-1|| isStart)) {
            res.push(new Coord(pos.x, pos.y+1))
        }
        res
    }

    String toString() {
        matrix.collect{it.join() }.join("\n")+"\n"+
        dist.collect{it.join("\t") }.join("\n")+"\n"+
        "\nS: "+start+"  E:"+dest
    }

    def findPath() {
        def nextPos = [start]
        while(nextPos.size()>0) {
            def nextCoord = nextPos.pop()
            def d = dist[nextCoord.y][nextCoord.x] + 1
            def adj = getAdjacent(nextCoord)
            adj.forEach {
                if (dist[it.y][it.x] > d) {
                    dist[it.y][it.x] = d
                    nextPos.push(it)
                }
            }
        }
        dist[dest.y][dest.x]
    }

}

def forest = new Forest(matrix)

//println forest
println forest.findPath()
//println forest
