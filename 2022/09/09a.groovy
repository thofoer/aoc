def input = new File('input2.txt').text.split("\n")

def hx = 0, hy = 0
def tx = 0, ty = 0

def path = new HashSet()

input.each {
    dir = it[0]
    dist = it.substring(2) as Integer
    dist.times {
        switch(dir) {
            case 'U': hy--; break;
            case 'D': hy++; break;
            case 'L': hx--; break;
            case 'R': hx++; break;
        }
        if (Math.abs(tx - hx) > 1 || Math.abs(ty - hy) > 1) {
            if (tx < hx) tx++
            if (tx > hx) tx--
            if (ty < hy) ty++
            if (ty > hy) ty--
        }
        path.add(tx+","+ty)
    }
}
println path.size()