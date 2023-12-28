#!/usr/bin/groovy
matrix = new File('input.txt').text.split("\n")

def closingSymbols(term) {
    stack = []
    res = term.split("").find { 
        if ( ["(", "[", "{", "<"].contains(it)) {
            stack.push(it)
        }
        else {
            last = stack.pop()
            if (! (last=="[" && it=="]" ||
                   last=="<" && it==">" ||
                   last=="{" && it=="}" ||
                   last=="(" && it==")")) {
                return true
            }
        }
        false
    }
    res == null ? stack.join().reverse() : null
}
scores = [ '(': 1, '[': 2, '{': 3, '<': 4 ]

println matrix.findResults{ it }

result = matrix.collect{ closingSymbols(it) }
               .findAll{ it } 
               .collect{ it.split("")
                          .inject(0 as BigInteger){ acc, sym -> 5*acc+scores[sym] } }
               .sort()

println result[result.size().intdiv(2)]
