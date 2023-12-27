def matrix = new File('input2.txt').text.split("\n").collect{ it.split("").collect{it.charAt(0)}}

class Coord {
    Integer x
    Integer y

    Coord(x ,y) {
        this.x = x
        this.y = y
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
                    dist[y][x] = 0
                }
                else if (matrix[y][x]=="S") {
                    start = new Coord(x,y)

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
        def current = elev(pos.x,pos.y)
        def isStart = current=="E"
        if (pos.x>0 && (elev(pos.x-1,pos.y)-current >=-1 || isStart)) {
            res.push(new Coord(pos.x-1, pos.y))
        }
        if (pos.x<width-1 && (elev(pos.x+1,pos.y)-current >=-1|| isStart)) {
            res.push(new Coord(pos.x+1, pos.y))
        }
        if (pos.y>0 && (elev(pos.x,pos.y-1)-current >=-1|| isStart)) {
            res.push(new Coord(pos.x, pos.y-1))
        }
        if (pos.y<height-1 && (elev(pos.x,pos.y+1)-current >=-1|| isStart)) {
            res.push(new Coord(pos.x, pos.y+1))
        }
        res
    }

    def findPath() {
        def nextPos = [dest]
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

        def allCoords = []
        (0..<width).each {x ->
            (0..<height).each { y ->
                allCoords.push(new Coord(x,y))
            }
        }
        allCoords.findAll { pos ->
            elev(pos.x, pos.y)=='a'
        }
        .collect {
            dist[it.y][it.x]
        }
        .sort()[0]
    }
}

def forest = new Forest(matrix)

println forest.findPath()

