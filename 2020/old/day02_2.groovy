def input = """1-3 a: abcde
1-3 b: cdefg
2-9 c: ccccccccc
"""
def counter = 0

input.eachLine( {line -> 
println line
def x = line =~/(.*)-(.*) (.): (.*)/
def first = x[0][1] as int
def second = x[0][2] as int
def letter = x[0][3]
def phrase = x[0][4]
def check1 = phrase[first-1] == letter
def check2 = phrase[second-1] == letter
 if (check1 ^ check2) {
counter++
}
})
println counter
