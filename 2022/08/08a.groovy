def input = new File('input2.txt').text.split("\n")
def matrix = input.collect{ it.split("").collect{ it as Integer} }

def dim = input.length

def matrixRot = new Integer[dim][dim]

dim.times { y ->
    dim.times { x ->
        matrixRot[x][y] = matrix[dim-y-1][x]
    }
}
def count = (dim-1)*4

(1..<dim-1).each { y ->
    (1..<dim-1).each { x ->
        height = matrix[y][x]
        if (   matrix[y][(0..<x)].every {it < height }
            || matrix[y][(x+1..<dim)].every {it < height }
            || matrixRot[x][(0..<(dim-y-1))].every {it < height }
            || matrixRot[x][((dim-y-1)+1..<dim)].every {it < height }
        )
        {
            count++
        }
    }
}
println count