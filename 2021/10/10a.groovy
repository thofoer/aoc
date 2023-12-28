#!/usr/bin/groovy
matrix = new File('input.txt').text.split("\n")

def firstIllegal(term) {
    stack = []
    res = term.split("").find { 
        if ( ["(", "[", "{", "<"].contains(it)) {
            stack.push(it)
            return false
        }
        else {
            last = stack.pop()
            if (! (last=="[" && it=="]" ||
                   last=="<" && it==">" ||
                   last=="{" && it=="}" ||
                   last=="(" && it==")")) {
                return it
            }
        }
    }
    res
}
scores = [")": 3, "]": 57, "}": 1197, ">": 25137]

println matrix.collect { firstIllegal(it.trim()) }.findAll{ it }.collect{ scores[it] }.sum()
