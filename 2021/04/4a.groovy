#!/usr/bin/groovy
input = new File('input.txt').text.split("\n\n")

boardCount = input.size()-1

draw = input[0].split(",").collect{ it as Integer }

boards = input[1..boardCount].collect { it.split("\n").collect{ it.trim().split("\s+").collect { it as Integer} } }

drawCount = draw.size()

def checkBoard(numbers, board) {

    if (    board.any { numbers.containsAll(it) } 
         || board.inject([[],[],[],[],[]]) { acc, row -> (0..4).each{ acc[it] <<= row[it] }; acc }
             .any { numbers.containsAll(it) }) {

        return board.flatten().findAll{ !numbers.contains(it) }.sum() * numbers[-1]
    }
    return -1;
}

(4..drawCount-1).any { pos -> 
    boards.any { board ->
        res = checkBoard(draw[0..pos], board) 
        if (res > 0) { 
            result = res 
            return true
        } 
    }
}
println result

