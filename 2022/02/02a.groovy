inputText = new File('input2.txt').text
lines = inputText.split("\n")
println lines.collect {score(it[0], it[2])}.sum()

def score( p, q) {

    i=(p.charAt(0) - "A".charAt(0))
    j=(q.charAt(0) - "X".charAt(0))

    res = 6
    if (i==j) {
        res = 3
    }
    if ( (i==0 && j==2 ) || (i-j==1)) {
        res = 0
    }
    res += 1+j

    return res
}