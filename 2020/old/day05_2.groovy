def array="""
BFFFBBFRRR
FFFBBBFRRR
BBFFBBFRLL"""


def list = array.split().collect{Integer.parseInt(it.replaceAll("R|B", "1").replaceAll("F|L", "0"), 2)}.sort()
println list.sort()
1.upto(list.size()-1) { if (list[it]-list[it-1]==2) println list[it] }
