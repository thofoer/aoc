#!/usr/bin/groovy
input  = new File('input.txt').text.split("\n\n")
values = input[0].split("")

image = [:]
input[1].split("\n").eachWithIndex{ row, r -> 
    row.split("").eachWithIndex{ pix, c -> 
        image[[c,r]]=pix=="#"
    }
}

def calcRange() {
    minX = 0
    maxX = 0
    minY = 0
    maxY = 0
    image.keySet().each {
        minX = minX>it[0] ? it[0] : minX
        maxX = maxX<it[0] ? it[0] : maxX
        minY = minY>it[1] ? it[1] : minY
        maxY = maxY<it[1] ? it[1] : maxY
    }
    [(minX-2..maxX+2),(minY-2..maxY+2)]
}

def getNewPix(x,y,infPix) {
    bits = (-1..1).collectMany{ r-> (-1..1).collect{ c-> image[[c+x,r+y]]!=null ? image[[c+x,r+y]]: infPix } }
    addr = Integer.parseInt(bits.collect{ it ? "1":"0" }.join(),2)
    values[addr] == "#"
}


def process(infPix) {
    tempImage = [:]
    (xrange, yrange) = calcRange()
    xrange.each{ x->
        yrange.each{ y-> 
            tempImage[[x,y]] = getNewPix(x,y,infPix)
        }
    }
    image = tempImage
}

def countPix() {
    image.values().count{it == true}
}

50.times{ n -> 
   process((n&1)==1)
   if (n==1) {
       println "2 -> "+countPix()
   }
}
println "50 ->"+countPix()

