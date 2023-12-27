def input = new File('input2.txt').text.split("\n")
x = 1
last  = x
z = 0
res = 0

def step() {
    xpos = (z-1)%40

    print ""+((last==xpos-1 || last==xpos || last==xpos+1) ? "#" : ".")
    if ( z%40 == 0) {
        println ""
    }
    last=x
}

input.each { cmd ->
    if (cmd == "noop") {
        z++
        step()
    }
    else {
        diff = cmd.substring(5) as Integer
        z++
        step()

        x += diff
        z++
        step()
    }
}
println res