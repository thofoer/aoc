#!/usr/bin/groovy 
inputText = new File('input.txt').text
input = inputText.split("\n")

cols = input[0].length()

def removeValues(bit, pos, valueList) {
        if (valueList.size()==1) {
            return valueList
        }
        else {
            occ = valueList.inject((1..cols).collect{""}) { acc, value -> (0..cols-1).each{ acc[it] += value[it]}; acc }
            count = occ[pos].split("").count("1")
            removeBit = ((count >= valueList.size()/2) ? (bit^1) : bit) as String;
            return valueList.findAll{ it[pos] != removeBit }
        }
}

def findValue(bit) {
        values = input.collect { it.split("") }
        (0..cols-1).each{ values = removeValues(bit, it, values) }
        return Integer.parseInt(values[0].join(), 2)
}

oxygen = findValue(1)
co2 = findValue(0) 

println(oxygen * co2)

