
input="13,x,x,x,x,x,x,37,x,x,x,x,x,461,x,x,x,x,x,x,x,x,x,x,x,x,x,17,x,x,x,x,19,x,x,x,x,x,x,x,x,x,29,x,739,x,x,x,x,x,x,x,x,x,41,x,x,x,x,x,x,x,x,x,x,x,x,23"

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
