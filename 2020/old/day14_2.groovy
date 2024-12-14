input="""mask = 000000000000000000000000000000X1001X
mem[42] = 100
mask = 00000000000000000000000000000000X0XX
mem[26] = 1"""

def createMask(value, mask) {
   res = mask.collect {it}
   bitCount = mask.count('X')

   newBits = Long.toString(value, 2)
   newBits = ("0"*(bitCount-newBits.length()))+newBits
   newBits = newBits.split("")
   z = 0
   newBits.stream().forEach {       
       while(res[z]!='X') { z++ }
       res[z] = it
   }
   Long.parseLong(res.join(), 2)
}

mem = [:]
input.split("\n").stream().forEach {

    if (it.startsWith("mask =")) {
         mask = it.substring(7).split("")
         xbits = mask.count("X")
         bitmasks=(0..<(2**xbits)).collect { createMask(it, mask) }
         clearmask = Long.parseLong(it.substring(7).replaceAll("0", "1").replaceAll("X", "0"), 2)
    }
    else {
         cmd = (it =~ "mem\\[(\\d+)\\] = (\\d+)")[0][1..2]
         addr = (cmd[0] as long)
         value = cmd [1] as long
         addresses = bitmasks.collect { it | (addr&clearmask) }
         addresses.stream().forEach { mem[it] = value }
    }
}

println mem.values().sum()

