//
//  Board.swift
//  TicTacToe
//
//  Created by Guillermo Lella on 2/28/21.
//

import Foundation

enum GameState {
    case GameWon(player: Player)
    case Tie
    case InProgress
}

// made it conform to Equatable so it can be compared
extension GameState: Equatable {
    public static func ==(lhs: GameState, rhs: GameState) -> Bool {
        switch (lhs, rhs) {
        case (.Tie, .Tie):
            return true
        case (.InProgress, .InProgress):
            return true
        case (.GameWon(let a), .GameWon(let b)):
            return a == b
        default:
            return false
        }
    }
}

enum Player: Int {
    case X = 1
    case O = 2
    
    func opponent() -> Player {
        switch self {
        case .X:
            return .O
        case .O:
            return .X
        }
    }
    
    func image() -> String {
        switch self {
        case .X:
            return "Cross.png"
        case .O:
            return "Nought.png"
        }
    }
}

struct Board {
    var slots:  [Int]
    var player: Player
    var state:  GameState
    init() {
        self.slots = [0,0,0,0,0,0,0,0,0]
        self.player = .X
        self.state = .InProgress
    }
    
    func isLegalAction(i: Int) -> Bool {
        if self.slots[i] == 0 {
            return true
        } else {
            return false
        }
    }
    
    mutating func performAction(i: Int) {
        // perform action
        self.slots[i] = self.player.rawValue
        // next Player's turn
        self.player = self.player.opponent()
    }
    
    func possibleMoves() -> [Int] {
        var actions = [Int]()
        for (index, element) in self.slots.enumerated() {
            if element == 0 {
                actions.append(index)
            }
        }
        return actions
    }
    
    mutating func checkWinner() {
        let winning_combinations = [[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6], [1, 4, 7], [2, 5, 8], [0, 4, 8], [2, 4, 6]]
        // check each player in turn if anybody won
        for player in [Player.X, Player.O] {
            for combination in winning_combinations {
                if  self.slots[combination[0]] == self.slots[combination[1]] &&
                    self.slots[combination[1]] == self.slots[combination[2]] &&
                    self.slots[combination[2]] == player.rawValue {
                    self.state = GameState.GameWon(player: player)
                    return
                }
            }
        }
        let available_moves = self.possibleMoves()
        if !available_moves.isEmpty {
            self.state = GameState.InProgress
            return
        } else {
            self.state = GameState.Tie
            return
        }
    }
    
    mutating func isEnded() -> Bool {
        self.checkWinner()
        switch self.state {
        case .GameWon(player: _):
            return true
        default:
            let available_moves = self.possibleMoves()
            return available_moves.isEmpty
        }
    }    
    
}
