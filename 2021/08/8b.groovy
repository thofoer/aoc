#!/usr/bin/groovy
input = new File('input.txt')
            .text.split("\n")
            .collect{ it.split("\\|")
                        .collect{ it.trim().split(" ")
                                            .collect{ it.split("").sort().join() } } }

def subtract(a,b) {
   (a.split("") - b.split("")).join()
}

def mapDigits(codes) {
    map = [:]

    codes.sort{ it.length() }
    map[1] = codes[0]
    map[7] = codes[1]
    map[4] = codes[2]
    map[8] = codes[9]
    codes6 = codes.findAll{ it.length()==6 }
    codes5 = codes.findAll{ it.length()==5 }
        
    codes6 -= map[6] = codes6.find{ subtract(it, map[7]).length() == 4 } 
    codes5 -= map[3] = codes5.find{ subtract(it, map[7]).length() == 2 }
    codes5 -= map[5] = codes5.find{ subtract(it, map[6]).length() == 0 }
    codes5 -= map[2] = codes5.find{ subtract(it, map[6]).length() == 1 }
    codes6 -= map[0] = codes6.find{ subtract(it, map[3]).length() == 2 }    
    map[9] = codes6[0]

    map.collectEntries{ [it.value, it.key] }
}

println input.collect{ line-> line[1].collect{ number -> mapDigits(line[0])[number] } }.collect{ it.join() as Integer }.sum()
