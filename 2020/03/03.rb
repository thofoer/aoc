grid = File.read("input.txt").split("\n")

WIDTH  = grid[0].size
HEIGHT = grid.size

puts [
        (1...HEIGHT).count{   |y| grid[y]  [y   % WIDTH] == ?# },
        (1...HEIGHT).count{   |y| grid[y]  [y*3 % WIDTH] == ?# },
        (1...HEIGHT).count{   |y| grid[y]  [y*5 % WIDTH] == ?# },
        (1...HEIGHT).count{   |y| grid[y]  [y*7 % WIDTH] == ?# },
        (1...HEIGHT/2).count{ |y| grid[2*y][y   % WIDTH] == ?# }
]
.reduce(&:*)
