def input = new File('input2.txt').text.split("\n")
def count = 10
def x = [0] * count
def y = [0] * count

def path = new HashSet()

input.each {
    dir = it[0]
    dist = it.substring(2) as Integer
    dist.times {
        switch(dir) {
            case 'U': y[0]--; break;
            case 'D': y[0]++; break;
            case 'L': x[0]--; break;
            case 'R': x[0]++; break;
        }
        (count-1).times { i ->
            if (Math.abs(x[i] - x[i+1]) > 1 || Math.abs(y[i] - y[i+1]) > 1) {
                if (x[i+1] < x[i]) x[i+1]++
                if (x[i+1] > x[i]) x[i+1]--
                if (y[i+1] < y[i]) y[i+1]++
                if (y[i+1] > y[i]) y[i+1]--
            }
        }
        path.add(x[count-1] + "," + y[count-1])
    }
}
println path.size()