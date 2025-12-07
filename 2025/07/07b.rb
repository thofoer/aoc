GRID  = File.readlines("input.txt").map(&:chars)
start = Complex(GRID[0].index(?S), 0)
MEM = {}

def solve(pos) = 
    MEM[pos] ||          
    MEM[pos] = case
                when pos.imag == GRID.size - 1 
                    1
                when GRID[pos.imag+1][pos.real] == ?^
                    solve(pos + 1+1i) + solve(pos - 1+1i)
                else
                    solve(pos + 0+1i)        
                end        

puts solve(start)
