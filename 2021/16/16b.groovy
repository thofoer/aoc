#!/usr/bin/groovy
text  = new File('input.txt').text.trim()
input = new BigInteger(text, 16).toString(2)

while(input.size() % 4 != 0) {
        input = "0" + input;
}
input = input.split("")

ix = 0

class Packet {
    int version
    int type
    long value

    Packet[] subpackets = []

    Packet(v,t) {
        version = v
        type = t
    }
    String toString() {
        "v=${version}  t=${type}  value=${value} ${subpackets.size()==0 ? '' : subpackets*.toString()}"
    }

    long calcValue() {
        switch(type) {
            case 0: return subpackets*.calcValue().sum()
            case 1: return subpackets.inject(1){ acc, p -> acc * p.calcValue() }
            case 2: return subpackets*.calcValue().min()
            case 3: return subpackets*.calcValue().max()
            case 4: return value
            case 5: return subpackets[0].calcValue()  > subpackets[1].calcValue() ? 1 : 0
            case 6: return subpackets[0].calcValue()  < subpackets[1].calcValue() ? 1 : 0
            case 7: return subpackets[0].calcValue() == subpackets[1].calcValue() ? 1 : 0
        }
    }
}

def parseBits(length) {
    res = Integer.parseInt(input[ix..(ix+length-1)].join(), 2)
    ix += length
    return res
}

def parseNext() {
   version = parseBits(3)
   type    = parseBits(3)
   def packet = new Packet(version, type)
   if (type == 4) {
       val  = []
       scan = true
       while(scan) {
           scan = input[ix] == "1"
           val.addAll(input[ix+1..ix+4])
           ix += 5
       } 
       packet.value = Long.parseLong(val.join(), 2)
   }
   else {
        if (input[ix++]=="0") {
            length = parseBits(15)   
            def max = length+ix
            while(ix<max) {
                sub = parseNext()
                packet.subpackets += sub
            }
        }
        else {
            def length = parseBits(11)
            length.times{
                sub = parseNext()
                packet.subpackets += sub
            }
        }
   }
   packet
}

result = parseNext()

println result.calcValue()
