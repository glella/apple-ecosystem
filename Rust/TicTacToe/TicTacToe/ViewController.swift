//
//  ViewController.swift
//  TicTacToe
//
//  Created by Guillermo Lella on 2/28/21.
//

import UIKit

class ViewController: UIViewController {
    
    var board = Board()
    
    // Array of outlets for the buttons so the AI can show its move
    @IBOutlet var buttons: [UIButton]!
    // Outlets for the label and play button
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var playButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func gameEnded() {
        switch board.state {
        case .GameWon(player: .X):
            label.text = "HUMAN WON!"
        case .GameWon(player: .O):
            label.text = "AI WON!"
        case .Tie:
            label.text = "DRAW"
        case .InProgress:
            // should never get here
            break
        }
        // disable buttons
        for button in buttons {
            button.isEnabled = false
        }
        // show message & button
        label.isHidden = false
        playButton.isHidden = false
    }

    @IBAction func playTapped(_ sender: UIButton) {
        // reset board
        board = Board()
        // reset UI: clear images & enable buttons
        for button in buttons {
            button.setImage(nil, for: UIControl.State())
            button.isEnabled = true
        }
        // hide message & button
        label.isHidden = true
        playButton.isHidden = true
    }
    
    @IBAction func action(_ sender: UIButton) {
        // Human turn
        let userAction = sender.tag
        if !board.isEnded() && board.state == .InProgress {
            if board.isLegalAction(i: userAction) {
                sender.setImage(UIImage(named: board.player.image()), for: UIControl.State())
                board.performAction(i: userAction)
            }
        } else {
            // game is finished check if somebody won and display it
            gameEnded()
            return
        }
        
        // AI turn - As human is 1st player check if game has not ended before AI's turn or if human has won
        if !board.isEnded() && board.state == .InProgress {
            // AI random moves x now
            let AIAction = board.possibleMoves().randomElement()!
            // both forms below work
            //if let button = buttons.filter({ $0.tag == AIAction }).first {
            if let button = buttons.first(where: { $0.tag == AIAction }) {
                button.setImage(UIImage(named: board.player.image()), for: UIControl.State())
            }
            board.performAction(i: AIAction)
            // re-check in anybody won after AI's turn
            board.checkWinner()
            if board.state != .InProgress {
                gameEnded()
                return
            }
        } else {
            // game is finished check if somebody won and display it
            gameEnded()
            return
        }
        
    }
    
}

