#!/usr/bin/groovy
text  = new File('input.txt').text.trim()
input = new BigInteger(text, 16).toString(2)

while(input.size() % 4 != 0) {
        input = "0" + input;
}
input = input.split("")

ix = 0

class Packet {
    int version = 0
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

    int versionSum() {
        if (subpackets.size()==0) {
            return version
        }
        version + subpackets.collect{ it.versionSum() }.sum()
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

println result.versionSum()
