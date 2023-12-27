numbers = new File('input2.txt').text.split("\n").collect {it as Integer }
size = numbers.size();
indices = (0..<size).collect{ it }

def mod(a,b) {
    r = a % b
    if (a<0) {
        r = b+r
    }
    return r
}

size.times {i ->
    pos = indices.indexOf(i)
    indices.removeAt(pos)
    indices.addAll(mod(pos+numbers[i], size-1), i)
}
zeroIndex = indices.indexOf(numbers.indexOf(0))

println([1000, 2000, 3000].collect {numbers[indices[(zeroIndex+it) % (size)]] }.sum())