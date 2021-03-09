//
//  Minimax.swift
//  TicTacToe
//
//  Created by Guillermo Lella on 3/1/21.
//

import Foundation

let MAX = 1000
let MIN = -1000

func minimaxABprunning(board: inout Board, depth: Int, alpha: Int, beta: Int) -> Int {
    var localAlpha = alpha
    var localBeta = beta
    
    if board.isEnded() {
        switch board.state {
        case .GameWon(player: .X):          // player won
            return -10 + depth
        case .GameWon(player: .O):          // AI won
            return 10 - depth
        default:
            return 0                        // draw
        }
    }
    
    if board.player == .O {                 // Simulate AI (Max of Minimax)
        var bestMove = MIN
        let possibleMoves = board.possibleMoves()
        for move in possibleMoves {
            var boardCopy = board           // copy the board
            boardCopy.performAction(i: move)// perform action in board copy
            let result = minimaxABprunning(board: &boardCopy, depth: depth+1, alpha: localAlpha, beta: localBeta)
            bestMove = max(bestMove, result)
            localAlpha = max(localAlpha, bestMove)
            // Alpha Beta Pruning
            if localBeta <= localAlpha {
                break
            }
        }
        return bestMove
        
    } else {                                // Simulate Human (Min of Minimax)
        var bestMove = MAX
        let possibleMoves = board.possibleMoves()
        for move in possibleMoves {
            var boardCopy = board           // copy the board
            boardCopy.performAction(i: move)// perform action in board copy
            let result = minimaxABprunning(board: &boardCopy, depth: depth+1, alpha: localAlpha, beta: localBeta)
            bestMove = min(bestMove, result)
            localBeta = min(localBeta, bestMove)
            // Alpha Beta Pruning
            if localBeta <= localAlpha {
                break
            }
        }
        return bestMove
    }
}

func findBestMove(board: Board) -> Int {
    var bestScore = -1000
    var bestMove = -1
    
    let possibleMoves = board.possibleMoves()
    for move in possibleMoves {
        var boardCopy = board               // copy the board
        boardCopy.performAction(i: move)    // perform action in board copy
        let score = minimaxABprunning(board: &boardCopy, depth: 0, alpha: MIN, beta: MAX)
        if score > bestScore {
            bestScore = score
            bestMove = move
        }
    }
    return bestMove
}
