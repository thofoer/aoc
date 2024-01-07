def input = """1-3 a: abcde
1-3 b: cdefg
2-9 c: ccccccccc
"""

def counter = 0

input.eachLine( {line -> 
println line
def x = line =~/(.*)-(.*) (.): (.*)/
def min = x[0][1] as int
def max = x[0][2] as int
def letter = x[0][3]
def phrase = x[0][4]
def count = phrase.count(letter)
if (count>=min && count<=max) {
counter++
}
})
println counter
