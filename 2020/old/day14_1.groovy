input="""mask = 000000000000000000000000000000X1001X
mem[42] = 100
mask = 00000000000000000000000000000000X0XX
mem[26] = 1"""

mem = [:]
input.split("\n").stream().forEach {
  
    if (it.startsWith("mask =")) {
         mask = it.substring(7);
         setMask   = Long.parseLong(mask.replaceAll("X", "0"), 2)
         clearMask = Long.parseLong(mask.replaceAll("X", "1"), 2)
    }
    else {
         cmd = (it =~ "mem\\[(\\d+)\\] = (\\d+)")[0][1..2]
         addr = cmd [0] as int
         value = cmd [1] as long
         mem[addr] = (value & clearMask) | setMask
    }
}

println mem.values().sum()
