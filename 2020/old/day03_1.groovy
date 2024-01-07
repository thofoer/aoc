def forest= """..##.......
#...#...#..
.#....#..#.
..#.#...#.#
.#...##..#.
..#.##.....
.#.#.#....#
.#........#
#.##...#...
#...##....#
.#..#...#.#"""

def array = forest.split()
def width = array[0].length()
def col = 0
def long counter1= 0
1.upto(array.length-1, { 
col+=3
if ( array[it][col%width] == "#") {
	counter1++;
}

})
println counter1
col=0
def long counter2=0
1.upto(array.length-1, {
col+=1
if ( array[it][col%width] == "#") {
        counter2++;
}

})
println counter2
col=0
def long counter3=0
1.upto(array.length-1, {
col+=5
if ( array[it][col%width] == "#") {
        counter3++;
}

})
println counter3
def long counter4=0
col=0
1.upto(array.length-1, {
col+=7
if ( array[it][col%width] == "#") {
        counter4++;
}

})
println counter4
col=0
def long counter5=0
(2..array.length-1).step(2).each {
col+=1
if ( array[it][col%width] == "#") {
        counter5++;
}

}
println counter5

println counter1 *counter2*counter3*counter4*counter5
