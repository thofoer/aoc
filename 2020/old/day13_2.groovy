
input="7,13,x,x,59,x,31,19"

bus=input.split(",").stream().collect { it=='x' ? 0 : it as long }

timestamp =  1L
waittime =1L 

(0..<bus.size()).forEach {
if (bus[it]!=0) {

    while(true) {
        if (((timestamp + it)) % bus[it] == 0) {
              waittime *= bus[it]
              break
        }
        timestamp +=waittime
println timestamp
    }
println timestamp
}
}
