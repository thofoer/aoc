#!/usr/bin/groovy
input  = new File('input.txt').text =~ /Player 1 starting position: (\d)\nPlayer 2 starting position: (\d)/
pos = [input[0][1] as Integer, input[0][2] as Integer]

scores = [0,0]

dieRolls = 0

def rollDie() {
    (dieRolls++ % 100)+1
}

def movePlayer(n) {
    steps = (rollDie() + rollDie() + rollDie()) % 10
    pos[n] = (pos[n] + steps) % 10
    if (pos[n]==0) {
        pos[n] = 10
    }
    scores[n] += pos[n]
}

while (scores[0]<1000 && scores[1]<1000) {
   movePlayer(0)
   if (scores[0]<1000) {
       movePlayer(1)
   }
}

println Math.min(scores[0], scores[1]) * dieRolls
