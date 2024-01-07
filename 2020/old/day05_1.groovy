def array="""
BFFFBBFRRR
FFFBBBFRRR
BBFFBBFRLL"""


println(array.split().collect{Integer.parseInt(it.replaceAll("R|B", "1").replaceAll("F|L", "0"), 2)}.max())
