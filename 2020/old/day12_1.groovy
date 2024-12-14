input = """F10
N3
F7
R90
F11"""

directionsRight = [ 'E', 'S', 'W', 'N' ] * 2
directionsLeft = directionsRight[-1..0]

def navDir(ship, direction, range) {
    switch(direction) {
        case 'N': ship[1] -= range; break;
        case 'S': ship[1] += range; break;
        case 'W': ship[0] -= range; break;
        case 'E': ship[0] += range; break;
    }
}

def nav(ship, step) {
    switch(step[0]) {
        case 'N': 
        case 'S': 
        case 'W': 
        case 'E': 
            navDir(ship, step[0], step[1])
            break;
        case 'F':
            navDir(ship, ship[2], step[1])
            break
        case 'R':
            ship[2] = directionsRight[directionsRight.indexOf(ship[2]) + (step[1]/90) ]
            break
        case 'L':
            ship[2] = directionsLeft[directionsLeft.indexOf(ship[2]) + (step[1]/90) ]
            break               
    }
    ship
}

ship = [0, 0, 'E' ]


target = input.split("\n").collect { (it =~ "(.)(.+)")[0][1..2] }.collect { [ it[0], it[1] as int ] }.inject(ship) { a, e -> nav(a, e) }


println Math.abs(target[0]) + Math.abs(target[1])

