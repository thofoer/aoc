def input = new File('input2.txt').text.split("\n")
x = 1
z = 0
res = 0

def step() {
    if ((z-19)%40 == 0) {
        res += x*(z+1)
    }
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