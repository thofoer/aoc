cryptKey = 811589153
numbers = new File('input2.txt').text.split("\n").collect {(it as Long) * cryptKey}
size = numbers.size();
indices = (0..<size).collect{ it }

int mod(a,b) {
    r = a % b
    if (a<0) {
        r = (b+r)
    }
    return r
}
10.times {
    size.times { i ->
        pos = indices.indexOf(i)
        indices.removeAt(pos)
        indices.addAll(mod(pos + numbers[i], size - 1), i)

    }
}
zeroIndex = indices.indexOf(numbers.indexOf(0L))
println([1000, 2000, 3000].collect {numbers[indices[(zeroIndex+it) % (size)]] }.sum())
