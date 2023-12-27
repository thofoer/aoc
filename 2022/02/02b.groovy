inputText = new File('input2.txt').text
lines = inputText.split("\n")

println lines.collect {
    i=(it.charAt(0) - "A".charAt(0))
    j=(it.charAt(2) - "X".charAt(0))
    score(i, choose(i, j))
}.sum()

def choose(p, q) {
    res = (p+q-1) % 3
    res < 0 ? 2 : res
}

def score(i, j) {
    (i == j ? 3 : ( (i == 0 && j == 2 ) || (i-j == 1)) ? 0 : 6) + j +1
}