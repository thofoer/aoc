#!/usr/bin/groovy
text  = new File('input.txt').text

parsed = (text =~ /target area: x=(\d+)\.\.(\d+), y=-(\d+)\.\.-(\d+)/ )

y1 =-(parsed[0][3] as Integer)

def triSum(n) {
    (n * (n + 1)) >> 1
}

println triSum(y1)
