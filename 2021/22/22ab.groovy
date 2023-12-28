#!/usr/bin/groovy
import groovy.transform.ToString

@ToString
class Cuboid {
 boolean on
    Integer[] x
    Integer[] y
    Integer[] z

    Cuboid(on, x, y, z){
        this.on=on
        this.x=x
        this.y=y
        this.z=z
    }

    def intersects(Cuboid o) {
          (x[0] <= o.x[1] && x[1]>=o.x[0]) && 
          (y[0] <= o.y[1] && y[1]>=o.y[0]) && 
          (z[0] <= o.z[1] && z[1]>=o.z[0])
    }

    def volume() {
        ((x[1]-x[0]+1) as BigInteger) * (y[1]-y[0]+1) * (z[1]-z[0]+1) 
    }

    def intersect(Cuboid o) {
        new Cuboid(
              o.on,
              [Math.max(x[0], o.x[0]), Math.min(x[1], o.x[1])],
              [Math.max(y[0], o.y[0]), Math.min(y[1], o.y[1])],
              [Math.max(z[0], o.z[0]), Math.min(z[1], o.z[1])])
    }
}


onCubes  = []
offCubes = []

def process(Cuboid cube) {

    def intersectAdd = []
    def intersectRemove = []

    onCubes.each {
        if(cube.intersects(it)) {
            intersectAdd += cube.intersect(it);
        }
    }

    offCubes.each {
        if(cube.intersects(it)) {
            intersectRemove += cube.intersect(it);
        }
    }
    onCubes.addAll(intersectRemove)
    offCubes.addAll(intersectAdd)
    if (cube.on) {
        onCubes += cube
    }
}

def getOnCount() {
    onCubes.collect{ it.volume() }.sum() - offCubes.collect{ it.volume() }.sum()
}

def input  = new File('input.txt').text.split("\n")
                  .collect{ (it =~ /(on|off) x=(.*)\.\.(.*),y=(.*)\.\.(.*),z=(.*)\.\.(.*)/)[0][1..7] }
                  .collect{ new Cuboid(it[0]=="on", 
                                       [it[1] as int, it[2] as int], 
                                       [it[3] as int, it[4] as int], 
                                       [it[5] as int, it[6] as int])}
input.eachWithIndex { cube, i ->
//    println "${i}   on=${onCubes.size}  off=${offCubes.size}"   
    process(cube)
    if (i==19) {
        println "part1: ${getOnCount()}" 
    }
}

println "part2: ${getOnCount()}" 

