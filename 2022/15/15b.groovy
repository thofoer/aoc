import groovy.transform.ToString

def input = new File('input2.txt').text.split("\n")

@ToString
class Sensor {
    int num
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

    def dist(int x, int y) {
        Math.abs(Math.abs(sx-x) + Math.abs(sy-y))
    }

    def dist(Sensor other) {
        Math.abs((Math.abs(sx-other.sx) + Math.abs(sy-other.sy)) - dist - other.dist)
    }

    def perimeter() {
        def res = new HashSet()
        for (int i=0; i<=dist+1; i++) {
            def u = sy + dist - i +1
            if (u<=4000000) {
                res.add( [[sx + i, u]])
                res.add( [[sx - i, u]])
            }
            def d =  sy - dist + i -1
            if (u<=4000000) {
                res .add( [[sx + i, d]])
                res .add([[sx - i, d]])
            }
        }
        res
    }
}


sensors = input.collect {
    def matcher = it =~ /Sensor at x=(-?\d+), y=(-?\d+): closest beacon is at x=(-?\d+), y=(-?\d+)/
    new Sensor(matcher[0][(1..4)].collect{ it as Integer })
}
sensors.withIndex().each {s,i ->s.num=i}

def comb(l,r=[]) {
    if (l) {
        r.addAll( [l.head(), l.tail()].combinations() )
        return comb(l.tail(), r)
    }
    return r
}

combs = comb(sensors)
pairs = combs.collect{ [it[0], it[1], it[0].dist(it[1])]}.findAll{it[2] == 2}.collectMany {[it[0], it[1]] }

first = pairs.head()
others = pairs.tail()

first.perimeter().each {

    def x = it[0][0]
    def y = it[0][1]

    def g = others.collect{ other -> other.dist(x,y)-other.dist}
    if (g.every{ v-> v<3}) {
        println ((4000000 as long) *x+y)
        return
    }

}


//matrix = (0..50).collect{['.'] * (50) }
//for(int x=0; x<50; x++) {
//    for(int y=0; y<50; y++) {
//        if (pairs[0].isWithin(x-10,y-10)) {
//            matrix[y][x] = '#'
//        }
//        if (pairs[1].isWithin(x-10,y-10)) {
//            matrix[y][x] = '#'
//        }
//        if (pairs[2].isWithin(x-10,y-10)) {
//            matrix[y][x] = '#'
//        }
//        if (pairs[3].isWithin(x-10,y-10)) {
//            matrix[y][x] = '#'
//        }
//    }
//}
//
//matrix.each{ println it.join("")}
//println "------"
//sensors[5].perimeter().each { matrix[it[1]][it[0]] = 'ö'}
//matrix.each{ println it.join("")}