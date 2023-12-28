#!/usr/bin/groovy
text  = new File('input.txt').text

parsed = (text =~ /target area: x=(\d+)\.\.(\d+), y=-(\d+)\.\.-(\d+)/ )

x1 =  parsed[0][1] as Integer
x2 =  parsed[0][2] as Integer
y1 =-(parsed[0][3] as Integer)
y2 =-(parsed[0][4] as Integer)

xrange = (x1..x2)
yrange = (y1..y2)
def triSum(n) {
    (n * (n + 1)) >> 1
}

def position(v, t) {
  triSum(v) - triSum(v-t)
}

def possibleXV() {
    (1..x2).findAll{ xv ->

        (1..xv).any{ steps -> 
            pos = position(xv, steps)
            //println "     v=${xv} s=${steps}  pos=${pos}  xrange=${xrange}  ${xrange.contains( position(xv, steps) )}"
            xrange.contains( position(xv, steps) ) 
        } 
    }
}

def inTarget(vx, vy) {
    (0..x2).any{ steps ->
      xPos = steps >= vx ? triSum(vx) : position(vx, steps)
      yPos = position(vy, steps)

//println "s=${steps}  pos=${xPos},${yPos}   "+xrange.contains(xPos)+"   "+yrange.contains(yPos)

      if (xrange.contains(xPos) && yrange.contains(yPos)) {
          return true
      }
      false
    }
}
/*
res = []
possibleXV().each{ xv->
   (y1..-y1).each { yv -> 
      if (inTarget(xv, yv)) {
          res << [xv, yv]
      }
   }
}
*/
//println res.size()

40.times {
    println "${it}  ${position(9,it)}"

}

      
