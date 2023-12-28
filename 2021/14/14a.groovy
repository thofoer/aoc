#!/usr/bin/groovy
input   = new File('input.txt').text.split("\n\n")
polymer = input[0]
rules   = input[1].split("\n").collect{ it.split(" -> ") }.collectEntries{ [it[0], it[1]] }

def step(p) {
    res = p.substring(0, 1)
    (p.length()-1).times{ 
        part = p.substring(it, it+2) 
        res += rules[part] + part[1]
    }
    res 
}



println polymer
println rules
10.times{ polymer = step(polymer) }
elements = polymer.split("").toUnique()
stats = elements.groupBy{ polymer.count(it) }.sort{ it.key }.entrySet()

println stats[-1].key - stats[0].key



