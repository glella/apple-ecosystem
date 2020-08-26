//
//  ViewController.swift
//  Project2
//
//  Created by Guillermo Lella on 8/25/20.
//  Copyright © 2020 Guillermo Lella. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!
    
    var countries = [String]()
    var score = 0
    var correctAnswer = 0
    var tries = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(showScore))
        
        
        countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "spain", "uk", "us"]
        
        button1.layer.borderWidth = 1
        button2.layer.borderWidth = 1
        button3.layer.borderWidth = 1
        
        button1.layer.borderColor = UIColor.lightGray.cgColor
        button2.layer.borderColor = UIColor.lightGray.cgColor
        button3.layer.borderColor = UIColor.lightGray.cgColor
        
        askQuestion()
    }

    func askQuestion(action: UIAlertAction! = nil) {
        countries.shuffle()
        
        button1.setImage(UIImage(named: countries[0]), for: .normal)
        button2.setImage(UIImage(named: countries[1]), for: .normal)
        button3.setImage(UIImage(named: countries[2]), for: .normal)
        
        correctAnswer = Int.random(in: 0...2)
        
        title = countries[correctAnswer].uppercased() + " - Score: \(score)"
        
        tries += 1
        
        if tries > 10 {
            let ac = UIAlertController(title: "Finished Game", message: "Final Score: \(score)", preferredStyle: .alert)
            ac.addAction(UIAlertAction(title: "Restart Game", style: .default, handler: resetGame))
            present(ac, animated: true)
        }
    }
   
    @IBAction func buttonTapped(_ sender: UIButton) {
        //print("sent by \(sender)")
        var title: String
        var message: String
        
        if sender.tag == correctAnswer {
            title = "Correct"
            message = "Good job!"
            score += 1
        } else {
            title = "Wrong"
            message = "That's the flag of \(countries[sender.tag].uppercased())"
            score -= 1
        }
        
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Continue", style: .default, handler: askQuestion))
        present(ac, animated: true)
        
    }
    
    func resetGame(action: UIAlertAction!) {
        score = 0
        tries = 0
        askQuestion()
    }
    
    @objc func showScore() {
        let ac = UIAlertController(title: "Current Score", message: "Score: \(score)", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Continue", style: .cancel, handler: {
            action in
                // do nothing
        }))
        present(ac, animated: true)
    }
    
}

