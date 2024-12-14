input = """F10
N3
F7
R90
F11"""

waypoint = [10, -1]
ship = [0, 0]

def navWaypoint(direction, range) {
    switch(direction) {
        case 'N': waypoint[1] -= range; break;
        case 'S': waypoint[1] += range; break;
        case 'W': waypoint[0] -= range; break;
        case 'E': waypoint[0] += range; break;
    }
}

def nav(ship, step) {
    switch(step[0]) {
        case 'N':
        case 'S':
        case 'W':
        case 'E':
            navWaypoint(step[0], step[1])
            break;
        case 'F':
            ship[0] = ship[0] + (step[1] * waypoint[0])
            ship[1] = ship[1] + (step[1] * waypoint[1])
            break
        case 'L':
        case 'R':
            if (step[1] == 180) {
                waypoint = [ waypoint[0]*-1, waypoint[1]*-1 ]
            }
            else if (step[1]==90 && step[0]=='R' || step[1]==270 && step[0]=='L') {
                waypoint = [ waypoint[1]*-1, waypoint[0] ]
            }
            else if (step[1]==270 && step[0]=='R' || step[1]==90 && step[0]=='L') {
                waypoint = [ waypoint[1], waypoint[0]*-1 ]
            }

    }
    //println " ${ship}   ${waypoint}"
    ship
}



target = input.split("\n").collect { (it =~ "(.)(.+)")[0][1..2] }.collect { [ it[0], it[1] as int ] }.inject(ship) { a, e -> nav(a, e) }

//println target
println Math.abs(target[0]) + Math.abs(target[1])
