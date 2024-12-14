def input = new File("input2.txt").text.split("\n").collect{ it.split(" -> ").collect{it.split(",").collect{it as Integer}}}
def vals = input.flatten()

maxWidth = vals.withIndex().findAll {v,i -> (i & 1)==0}.collect{it[0]}.max() * 2
maxHeight = vals.withIndex().findAll {v,i -> (i & 1)==1}.collect{it[0]}.max() + 2

matrix = (0..maxHeight).collect{['.'] * (maxWidth+1) }

input.each {
    def x1=it[0][0]
    def y1=it[0][1]
    for(int i=1; i<it.size(); i++){
        def x2 =it[i][0]
        def y2=it[i][1]
        if (x1==x2) {
            (y1..y2).each {
                matrix[it][x1] = '#'
            }
        }
        else {
            (x1..x2).each {
                matrix[y1][it] = '#'
            }
        }
        x1=x2
        y1=y2
    }
}

(0..maxWidth).each { matrix[maxHeight][it]='#'}

def dump() {
    matrix.each { println it.join("") }
    println ""
}

def drop() {
    def dx=500
    def dy = 0
    def isDown = false

    while(!isDown && dy<maxHeight) {
        if (matrix[dy+1][dx] == '.') {
            dy++
        }
        else if (matrix[dy+1][dx-1] == '.') {
            dy++
            dx--
        }
        else if (matrix[dy+1][dx+1] == '.') {
            dy++
            dx++
        }
        else {
            isDown = true
        }
    }
    if (isDown){
        matrix[dy][dx] = 'o'
    }
    return dy != 0
}


count = 0
while(drop()) {
    count++
}
//dump()
println count + 1