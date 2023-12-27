def input = new File('input2.txt').text.split("\n")
def matrix = input.collect{ it.split("").collect{ it as Integer} }

def dim = input.length

def matrixRot = new Integer[dim][dim]

dim.times { y ->
    dim.times { x ->
        matrixRot[x][y] = matrix[dim-y-1][x]
    }
}

def countUntilGreater(arr, max) {
    c = 0
    for(int i=0; i<arr.size(); i++) {
        if (arr[i]>=max) {
            return c+1;
        }
        c++
    }
    return c
}

def best = 0

(1..<dim-1).each { y ->
    (1..<dim-1).each { x ->
        height = matrix[y][x]

        score = countUntilGreater(matrix[y][(0..<x)].reverse(), height)
            * countUntilGreater(matrix[y][(x+1..<dim)], height)
            * countUntilGreater(matrixRot[x][(0..<(dim-y-1))].reverse(), height)
            * countUntilGreater(matrixRot[x][((dim-y-1)+1..<dim)], height)

        if (score > best) {
            best = score;
        }
    }
}
println best