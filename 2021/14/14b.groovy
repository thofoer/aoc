#!/usr/bin/groovy
input   = new File('input.txt').text.split("\n\n")
rules   = input[1].split("\n").collect{ it.split(" -> ") }.collectEntries{ [it[0], it[1]] }

polymer = [:]
(input[0].length()-1).times {
    part = input[0].substring(it, it+2)
    polymer[part] = 1 + (polymer[part] ?: 0 as BigInteger)
}

def step() {
    res = [:]
    polymer.entrySet().each{
        element = it.key
        middle  = rules[element]
        left    = element[0] + middle
        right   = middle + element[1]
        res[left]  = it.value + (res[left]  ?: 0)
        res[right] = it.value + (res[right] ?: 0)
    }
    polymer = res
}

40.times{ step() }

count = polymer.entrySet().collectMany{ [it.key[0], it.key[1]] }.collectEntries{ [it, 0 as BigInteger] }
polymer.entrySet().each{ count[it.key[0]]+=it.value; count[it.key[1]]+=it.value }

count = count.entrySet().collectEntries{ [it.key, it.value / 2 ] }.entrySet().sort{ it.value }
println (count[-1].value - count[0].value as BigInteger)
