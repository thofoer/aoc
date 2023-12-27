import groovy.transform.ToString

def input = new File('input2.txt').text.split("\n")
def searchLine = 2000000

@ToString
class Sensor {
    int sx
    int sy
    int bx
    int by
    int dist

    Sensor(List<Integer> v) {
        sx = v[0]
        sy = v[1]
        bx = v[2]
        by = v[3]
        dist = Math.abs(sx-bx) +Math.abs(sy-by)
    }

    def isWithin(x,y) {
        Math.abs(sx-x) + Math.abs(sy-y) <= dist
    }
}

sensors = input.collect {
    def matcher = it =~ /Sensor at x=(-?\d+), y=(-?\d+): closest beacon is at x=(-?\d+), y=(-?\d+)/
    new Sensor(matcher[0][(1..4)].collect{ it as Integer })
}

def minX = sensors.collect{ it.sx-it.dist }.min()
def maxX = sensors.collect{ it.sx+it.dist }.max()
def beacons = sensors.collect{ [it.bx, it.by] }.toSet().findAll{ it[1] == searchLine }.size()

//println ""+minX+".."+maxX+"   beacons="+beacons

z = 0
for (int x=minX; x<maxX; x++) {
    if ( sensors.any{it.isWithin(x, searchLine)}) {
        z++
    }
}
println z - beacons
