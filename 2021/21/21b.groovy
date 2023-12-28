#!/usr/bin/groovy

import groovy.transform.EqualsAndHashCode

@EqualsAndHashCode
class Game {
    int[] pos
    int[] scores

    Game(p, s) {
        pos = p
        scores = s
    }

    Game move(player, steps) {
        def newPos = pos.clone()
        newPos[player] = (steps-1+pos[player]) % 10 + 1
        def newScores = scores.clone()
        newScores[player] += newPos[player]
        new Game(newPos, newScores)
    }

    def winner() {
        scores[0]>=21 ? 0 : scores[1]>=21 ? 1 : null
    }
}


startPos = [1,5]

diceSumPossibilities = [3: 1, 4: 3, 5: 6, 6: 7, 7: 6, 8: 3, 9: 1]

wins = [0 as long, 0 as long]
games = [:]
turn = 0

games[new Game(startPos, [0, 0])] = 1 

while (!games.isEmpty()) {
    tempGames = [:]
    games.entrySet().each { gameEntry ->
        game = gameEntry.key
        count = gameEntry.value
        (3..9).each { roll ->
            possCount = (diceSumPossibilities[roll] * count) as long
            newGame = game.move(turn, roll);
            winner = newGame.winner()
            if (winner!=null) {
                wins[winner] += possCount
            } 
            else {
                oldValue = tempGames[newGame] ?: 0
                tempGames[newGame] = oldValue + possCount
            }
        }
    }
    turn ^= 1
    games = tempGames
}
println wins.max()            
