list="""2 * 3 + (4 * 5)
5 + (8 * 3 + 9 + 3 * 4 * 3)
5 * 9 * (7 * 3 * 3 + 9 * 3 + (8 + 6 * 4))
((2 + 4 * 9) * (6 + 9 * 8 + 6) + 6) + 2 + 4 * 2"""

def calcTerm(s) {
    
    acc = 0
    op = "+"
    s.split(" ").stream().forEach {
        if (it=="*" || it=="+") {
            op = it
        }
        else {
            n = it as long 
            acc = op=="+" ? acc+n : acc*n
        }
    }
    acc
}


def calc(input) {
    while (input.contains("(")) {
        (input =~ "\\([ 0-9+\\*]*?\\)")[0..-1].forEach {

            term = it.replaceAll("\\(|\\)","")
            input = input.replaceAll(it.replaceAll("\\*", "\\\\*")
                                       .replaceAll("\\+", "\\\\+")
                                       .replaceAll("\\(", "\\\\(")
                                       .replaceAll("\\)", "\\\\)"), 
                                     calcTerm(term) as String)
    
            }
    }
    calcTerm(input)
}
println list.split("\n").collect{ calc(it) }.sum()
